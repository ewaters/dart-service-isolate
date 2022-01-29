import 'dart:async';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:change_case/change_case.dart';

import 'generated/descriptor.pb.dart' as pb;

class ServiceIsolateBuilder implements Builder {
  final String _descriptorDir;
  final String _generatedDir;
  final String _userCreatedDir;
  final String _configMessageSuffix;

  static String _getDef(BuilderOptions opts, String key, String def) =>
      opts.config[key] as String? ?? def;

  ServiceIsolateBuilder(BuilderOptions opts)
      : _descriptorDir = _getDef(opts, "descriptor_dir", "lib/src/generated"),
        _generatedDir = _getDef(opts, "generated_dir", "lib/src/generated"),
        _userCreatedDir = _getDef(opts, "user_created_dir", "lib/src"),
        _configMessageSuffix =
            _getDef(opts, "config_message_suffix", "ServiceConfig");

  @override
  Future<void> build(BuildStep buildStep) async {
    final svcBuilder = _ServiceBuilder(this, buildStep);

    final descSet = pb.FileDescriptorSet.fromBuffer(
        await buildStep.readAsBytes(buildStep.inputId));
    for (final pb.FileDescriptorProto desc in descSet.file) {
      for (final pb.ServiceDescriptorProto svc in desc.service) {
        svcBuilder.addService(svc);
      }
    }

    await svcBuilder.finalize();
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      path.join(_descriptorDir, '{{}}.descriptor.pb'): [
        path.join(_generatedDir, '{{}}.interface.dart'),
        path.join(_generatedDir, '{{}}.isolate.dart'),
        path.join(_userCreatedDir, '{{}}.dart'),
      ],
    };
  }
}

class _ServiceBuilder {
  final BuildStep _buildStep;
  final ServiceIsolateBuilder _parent;

  final _interfaceFile = StringBuffer();
  final _isolateFile = StringBuffer();
  final _serviceFile = StringBuffer();

  _ServiceBuilder(ServiceIsolateBuilder parent, BuildStep buildStep)
      : _buildStep = buildStep,
        _parent = parent {
    _initBuffers();
  }

  static void _log(String msg) => print("_ServiceBuilder: $msg");

  AssetId _outputMatching({String? suffix, String? prefix}) =>
      _buildStep.allowedOutputs.where((a) {
        if (suffix != null && !a.path.endsWith(suffix)) {
          return false;
        }
        if (prefix != null && !a.path.startsWith(prefix)) {
          return false;
        }
        return true;
      }).first;

  AssetId get _interfaceAsset => _outputMatching(suffix: ".interface.dart");
  AssetId get _isolateAsset => _outputMatching(suffix: ".isolate.dart");
  AssetId get _serviceAsset => _outputMatching(prefix: _parent._userCreatedDir);

  String get _interfacePath => _interfaceAsset.path;
  String get _isolatePath => _isolateAsset.path;
  String get _servicePath => _serviceAsset.path;
  String get _servicePBPath =>
      _buildStep.inputId.path.replaceAll(".descriptor.pb", ".pb.dart");

  static const String _generatedHeader = "// Generated code: do not modify";
  static const String _ignoreHeader =
      "// ignore_for_file: public_member_api_docs";

  void _initBuffers() {
    _initInterface();
    _initService();
    _initIsolate();
  }

  void _initInterface() {
    String relServicePBPath =
        path.relative(_servicePBPath, from: path.dirname(_interfacePath));
    _interfaceFile.writeAll([
      _generatedHeader,
      _ignoreHeader,
      'import "$relServicePBPath";',
      'export "$relServicePBPath";',
    ], "\n");
  }

  void _initService() {
    String relInterfacePath =
        path.relative(_interfacePath, from: path.dirname(_servicePath));
    String relIsolatePath =
        path.relative(_isolatePath, from: path.dirname(_servicePath));
    _serviceFile.writeAll([
      '/// REMOVE THIS TEXT: Edit this file and flesh out the service',
      'import "$relInterfacePath";',
      'export "$relInterfacePath";',
      'export "$relIsolatePath";',
    ], "\n");
  }

  void _initIsolate() {
    String relServicePath =
        path.relative(_servicePath, from: path.dirname(_isolatePath));
    _isolateFile.writeAll([
      _generatedHeader,
      _ignoreHeader,
      "import 'package:service_isolate/service_isolate.dart';",
      "import 'package:stream_channel/isolate_channel.dart' as sc;",
      "import 'dart:isolate' show SendPort;",
      "import 'dart:async';",
      "import '$relServicePath';",
    ], "\n");
  }

  String _qualifyType(String type) {
    if (type.startsWith(".")) {
      return type.substring(1);
    }
    throw "_qualifyType('$type') unknown";
  }

  String _methodName(pb.MethodDescriptorProto m) =>
      ChangeCase(m.name).toCamelCase();

  void addService(final pb.ServiceDescriptorProto svc) {
    final String serviceName = "${svc.name}Service";
    final String interfaceName = "${serviceName}Interface";
    final String isolateName = "${serviceName}Isolate";

    final String configMessageType = _parent._configMessageSuffix.isEmpty
        ? ""
        : svc.name + _parent._configMessageSuffix;

    _log("configMessageType $configMessageType");

    _interfaceFile.writeAll(['', "abstract class $interfaceName {", ''], "\n");

    _serviceFile.writeAll([
      '',
      "class $serviceName extends $interfaceName {",
      if (configMessageType.isNotEmpty)
        "  static Future<$interfaceName> create($configMessageType config) async {"
      else
        "  static Future<$interfaceName> create() async {",
      "    return $serviceName();",
      "  }",
      '',
    ], "\n");

    _isolateFile.writeAll([
      '',
      'void _log(String msg) => print("$isolateName: \$msg");',
      '',
      "/// A generated class that implements the [$interfaceName] via an",
      "/// Isolate.",
      "///",
      "/// Depends upon manually written code in `" +
          path.relative(_servicePath, from: path.dirname(_isolatePath)) +
          "` that implements",
      "/// the concrete [serviceName] class.",
      "class $isolateName extends $interfaceName {",
      "  final ServiceIsolate _iso;",
      "  $isolateName._new(this._iso);",
      '',
      "/// Creates a new $isolateName.",
      if (configMessageType.isNotEmpty)
        "  static Future<$isolateName> create($configMessageType config) async =>"
            "$isolateName._new(await ServiceIsolate.spawn(_runIsolate, "
            "firstMessage: config));"
      else
        "  static Future<$isolateName> create() async =>"
            "$isolateName._new(await ServiceIsolate.spawn(_runIsolate));",
      '',
      "/// Closes the underlying ServiceIsolate.",
      "  Future close() => _iso.close();",
      '\n',
    ], "\n");

    final runIsolate = StringBuffer();
    runIsolate.writeAll([
      'void _runIsolate(List<Object> args) async {',
      if (configMessageType.isNotEmpty)
        '  final svc = await $serviceName.create(args[1] as $configMessageType);'
      else
        '  final svc = await $serviceName.create();',
      '  final Map<int, StreamController> clientStreamControllers = {};',
      '  final channel = sc.IsolateChannel.connectSend(args[0] as SendPort);',
      '  channel.stream.listen(',
      '    (reqData) {',
      '    final helper = ServiceIsolateHelper(channel, '
          'reqData, clientStreamControllers);',
      '    try {',
      '      switch (reqData.method) {',
    ], "\n");

    for (final m in svc.method) {
      final method = "/${svc.name}.${m.name}";
      final dartMethodName = _methodName(m);
      final requestType = _qualifyType(m.inputType);
      final responseType = _qualifyType(m.outputType);
      final signature = "${m.serverStreaming ? "Stream" : "Future"}<" +
          _qualifyType(m.outputType) +
          "> $dartMethodName(" +
          (m.clientStreaming
              ? "Stream<$requestType> stream"
              : "$requestType request") +
          ")";

      _interfaceFile.writeln("  $signature;");
      _isolateFile.writeAll([
        "  @override",
        "  $signature =>",
        if (m.clientStreaming && m.serverStreaming)
          '_iso.bidiStream("$method", stream)'
        else if (m.clientStreaming)
          '_iso.clientStream("$method", stream)'
        else if (m.serverStreaming)
          '_iso.serverStream("$method", request)'
        else
          '_iso.request("$method", request)',
        if (m.serverStreaming)
          '.map((obj) => obj as $responseType);'
        else
          '.then((obj) => obj as $responseType);',
        ''
      ], "\n");
      _serviceFile.writeAll([
        '',
        "  @override",
        "  $signature " + (m.serverStreaming ? "" : "async ") + "{",
        "    throw 'not implemented';",
        "  }",
        ''
      ], "\n");

      final String futureArgs = 'helper.onData, onError: helper.onError';
      final String listenArgs = '$futureArgs, onDone: helper.onDone';

      runIsolate.writeln('case "$method":');
      if (m.clientStreaming) {
        runIsolate.writeAll([
          '{',
          'if (!clientStreamControllers.containsKey(reqData.id)) {',
          '  final controller = StreamController<$requestType>();',
          '  clientStreamControllers[reqData.id] = controller;',
          if (m.serverStreaming)
            '  svc.$dartMethodName(controller.stream).listen($listenArgs);'
          else
            '  svc.$dartMethodName(controller.stream).then($futureArgs);',
          '}',
          'helper.handleClientStream();',
          '}',
        ], "\n");
      } else if (m.serverStreaming) {
        runIsolate
            .writeln('svc.$dartMethodName(reqData.object! as $requestType)'
                '.listen($listenArgs);');
      } else {
        runIsolate
            .writeln('svc.$dartMethodName(reqData.object! as $requestType)'
                '.then($futureArgs);');
      }
      runIsolate.writeln('break;');
    }

    runIsolate.writeAll([
      '    default:',
      '        helper.onError("_runIsolate.listen got unexpected '
          'method " + reqData.method);',
      '      }',
      '    } catch (e) {',
      '        helper.onError(e.toString());',
      '      }',
      '    },',
      '    onError: (error) {',
      '      _log("_runIsolate.listen error \$error");',
      '      channel.sink.addError(error);',
      '    },',
      '    onDone: () {',
      '      _log("_runIsolate.listen done");',
      '    },',
      '  );',
      '}',
    ], "\n");
    _interfaceFile.writeln("}");
    _serviceFile.writeln("}");
    _isolateFile.writeln("}");

    _isolateFile.writeAll([
      '',
      runIsolate.toString(),
    ], "\n");
  }

  Future finalize() async {
    final formatter = DartFormatter(pageWidth: 80, fixes: StyleFix.all);
    Future writeAsset(AssetId asset, StringBuffer buf) async {
      String out = formatter.format(buf.toString());
      final f = File(asset.path);
      // TODO: This doesn't seem to return true even if the file exists.
      if (f.existsSync()) {
        if (f.readAsStringSync() == out) {
          _log("No changes to ${asset.path}");
        } else {
          _log("Changes needed to ${asset.path}");
        }
      } else {
        _log("File ${asset.path} doesn't exist; writing it");
      }
      // Write it even if there are no changes just to mark it as tracked.
      return _buildStep.writeAsString(asset, out);
    }

    writeAsset(_interfaceAsset, _interfaceFile);
    writeAsset(_isolateAsset, _isolateFile);
    if (!File(_serviceAsset.path).existsSync()) {
      writeAsset(_serviceAsset, _serviceFile);
    } else {
      _log("Skipping ${_serviceAsset.path} as it already exists");
    }
  }
}
