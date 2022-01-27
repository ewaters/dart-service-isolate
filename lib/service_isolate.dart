import 'dart:async';
import 'dart:isolate' show ReceivePort, Isolate;

import 'package:stream_channel/isolate_channel.dart' as sc;

/// The message type sent over the [ServiceIsolate] ports.
class IsolateMessage {
  /// Each session of a service request is assigned a unique ID. Required.
  ///
  /// Simple requests will have one message sent/received with this ID.
  /// Streaming requests (client, server, bidi) will use this ID for all related
  /// messages.
  final int id;

  /// The name of the method, in the form "/<service>.<method>". Required.
  final String method;

  /// The request or response message proto. May be null.
  Object? object;

  /// An exception. Sent only from the server to the client.
  Object? exception;

  /// With streaming, indicates that either the client or server stream closed.
  bool? streamClosed;

  /// Constructor. [id] and [method] are required. Not for general use.
  IsolateMessage(this.id, this.method,
      {this.object, this.exception, this.streamClosed});

  /// Debug helper.
  @override
  String toString() {
    final str = StringBuffer();
    str.write("$id $method");
    if (object != null) {
      str.write(", <object>");
    }
    if (exception != null) {
      str.write(", <exception>");
    }
    if (streamClosed != null) {
      str.write(", streamClosed $streamClosed");
    }
    return str.toString();
  }

  /// Build up a derived response message from a given request.
  IsolateMessage add({Object? object, Object? exception, bool? streamClosed}) =>
      IsolateMessage(id, method,
          object: object, exception: exception, streamClosed: streamClosed);
}

/// A protocol buffer based isolate supporting streaming methods.
///
/// Intended for usage in generated code.
class ServiceIsolate {
  final sc.IsolateChannel _channel;
  final ReceivePort _receivePort;
  final Isolate _iso;
  late StreamSubscription _listenSub;

  bool _closed = false;

  final Map<int, Completer<IsolateMessage>> _completers = {};
  final Map<int, StreamController<IsolateMessage>> _controllers = {};

  ServiceIsolate._new(this._channel, this._receivePort, this._iso);

  static void _log(String msg) => print("    ServiceIsolate: $msg");

  /// Spawns a new [ServiceIsolate].
  ///
  /// If [firstMessage] is present, it will be sent in the isolate setup. Must
  /// be isolate channel safe.
  static Future<ServiceIsolate> spawn(void Function(List<Object>) runIsolate,
      {Object? firstMessage}) async {
    final rp = ReceivePort();
    final channel = sc.IsolateChannel.connectReceive(rp);
    _log("spawn() is starting an isolate");
    final iso = await Isolate.spawn(
        runIsolate, [rp.sendPort, if (firstMessage != null) firstMessage]);
    // iso.errors.listen((e) => _log("isolate error $e"));
    _log("spawn() has started an isolate");
    final svc = ServiceIsolate._new(channel, rp, iso);
    svc._listen();
    return svc;
  }

  /// Clean up the various resources used in the isolate.
  Future close() async {
    await _listenSub.cancel();
    _iso.kill(priority: Isolate.immediate);
    _receivePort.close();
    await _channel.sink.close();
    _closed = true;
  }

  void _listen() {
    _listenSub = _channel.stream.listen(
      (data) {
        if (data is! IsolateMessage) {
          throw "_listen got unexpected $data";
        }
        _log("_listen got $data");
        if (_completers.containsKey(data.id)) {
          _completers.remove(data.id)!.complete(data);
        } else if (_controllers.containsKey(data.id)) {
          _controllers[data.id]!.sink.add(data);
        } else {
          throw "Unhandled event from isolate $data";
        }
      },
      onError: (e) {
        _log("_listen error $e");
      },
      onDone: () {
        _log("_listen done");
      },
    );
  }

  static int _newMessageID() => DateTime.now().microsecondsSinceEpoch;

  void _assertNotClosed() {
    if (_closed) throw "Can't call methods on a closed ServiceIsolate";
  }

  /// Non-streaming simple request.
  Future<Object> request(String method, Object request) async {
    _assertNotClosed();
    final completer = Completer<IsolateMessage>();
    final id = _newMessageID();
    _completers[id] = completer;
    _channel.sink.add(IsolateMessage(id, method, object: request));

    IsolateMessage result = await completer.future;
    if (result.exception != null) {
      throw result.exception!;
    }
    if (result.object == null) {
      throw "$method: No object set; error likely in _runIsolate";
    }
    return result.object!;
  }

  /// Server-streaming request.
  Stream<Object> serverStream(String method, Object request) {
    _assertNotClosed();
    final id = _newMessageID();
    // ignore: close_sinks
    final controller = StreamController<IsolateMessage>();
    _controllers[id] = controller;
    _channel.sink.add(IsolateMessage(id, method, object: request));

    final response = StreamController<Object>();
    controller.stream.listen((IsolateMessage msg) {
      if (msg.exception != null) {
        response.addError(msg.exception!);
      } else if (msg.object != null) {
        response.add(msg.object!);
      } else if (msg.streamClosed ?? false) {
        response.close();
        controller.sink.close();
      } else {
        response.addError("serverStream received invalid IsolateMessage");
      }
    }, onDone: () {
      _log("serverStream($method) listen done");
    });
    return response.stream;
  }

  /// Client-streaming request.
  Future<Object> clientStream(String method, Stream<Object> request) async {
    _assertNotClosed();
    final completer = Completer<IsolateMessage>();
    final id = _newMessageID();
    _completers[id] = completer;

    await for (final obj in request) {
      _channel.sink.add(IsolateMessage(id, method, object: obj));
    }
    _channel.sink.add(IsolateMessage(id, method, streamClosed: true));

    IsolateMessage result = await completer.future;
    if (result.exception != null) {
      throw result.exception!;
    }
    if (result.object == null) {
      throw "$method: No object set; error likely in _runIsolate";
    }
    return result.object!;
  }

  /// Bi-directional streaming request.
  Stream<Object> bidiStream(String method, Stream<Object> request) {
    _assertNotClosed();
    final id = _newMessageID();
    // ignore: close_sinks
    final controller = StreamController<IsolateMessage>();
    _controllers[id] = controller;

    request.listen((obj) {
      _channel.sink.add(IsolateMessage(id, method, object: obj));
    }, onDone: () {
      _channel.sink.add(IsolateMessage(id, method, streamClosed: true));
    });

    final response = StreamController<Object>();
    controller.stream.listen((IsolateMessage msg) {
      if (msg.exception != null) {
        response.addError(msg.exception!);
      } else if (msg.object != null) {
        response.add(msg.object!);
      } else if (msg.streamClosed ?? false) {
        response.close();
        controller.sink.close();
      } else {
        response.addError("serverStream received invalid IsolateMessage");
      }
    }, onDone: () {
      _log("serverStream($method) listen done");
    });
    return response.stream;
  }
}
