import 'dart:async';

import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:change_case/change_case.dart';

import 'generated/descriptor.pb.dart' as pb;

class ServiceIsolateBuilder implements Builder {
  final String _descriptorDir;
  final String _generatedDir;
  final String _userCreatedDir;

  static String _getDef(BuilderOptions opts, String key, String def) =>
      opts.config[key] as String? ?? def;

  ServiceIsolateBuilder(BuilderOptions opts)
      : _descriptorDir = _getDef(opts, "descriptor_dir", "lib/src/generated"),
        _generatedDir = _getDef(opts, "generated_dir", "lib/src/generated"),
        _userCreatedDir = _getDef(opts, "user_created_dir", "lib/src");

  @override
  Future<void> build(BuildStep buildStep) async {
    print("ServiceIsolateBuilder build ${buildStep.inputId.path} ($buildStep)");
    for (var out in buildStep.allowedOutputs) {
      print("  allowed output: ${out.path}");
    }

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
    _log("path from $_interfacePath to $_servicePBPath is $relServicePBPath");
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
    _log("Add service ${svc.name}");
    final String serviceName = "${svc.name}Service";
    final String interfaceName = "${serviceName}Interface";
    final String isolateName = "${serviceName}Isolate";

    _interfaceFile.writeAll(['', "abstract class $interfaceName {", ''], "\n");

    _serviceFile.writeAll([
      '',
      "class $serviceName extends $interfaceName {",
      "  static Future<$interfaceName> create() async {",
      "    return $serviceName();",
      "  }",
      '',
    ], "\n");

    _isolateFile.writeAll([
      '',
      "class $isolateName extends $interfaceName {",
      '',
    ], "\n");

    for (final m in svc.method) {
      final signature = "${m.serverStreaming ? "Stream" : "Future"}<" +
          _qualifyType(m.outputType) +
          "> ${_methodName(m)}(" +
          (m.clientStreaming
              ? "Stream<${_qualifyType(m.inputType)}> stream"
              : "${_qualifyType(m.inputType)} request") +
          ")";
      _interfaceFile.writeln("  $signature;");
      _serviceFile.writeAll([
        "  @override",
        "  $signature {",
        "    throw 'not implemented';",
        "  }",
        ''
      ], "\n");
      _isolateFile.writeAll([
        "  @override",
        "  $signature " + (m.serverStreaming ? "" : "async ") + "{",
        "    throw 'not implemented';",
        "  }",
        ''
      ], "\n");
    }

    _interfaceFile.writeln("}");
    _serviceFile.writeln("}");
    _isolateFile.writeln("}");
  }

  Future finalize() async {
    _log("Writing file $_interfacePath with ${_interfaceFile.toString()}");
    await _buildStep.writeAsString(_interfaceAsset, _interfaceFile.toString());

    _log("Writing file $_servicePath with ${_serviceFile.toString()}");
    await _buildStep.writeAsString(_serviceAsset, _serviceFile.toString());

    _log("Writing file $_isolatePath with ${_isolateFile.toString()}");
    await _buildStep.writeAsString(_isolateAsset, _isolateFile.toString());
  }
}
