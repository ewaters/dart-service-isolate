import 'package:service_isolate/service_isolate.dart';
import 'package:stream_channel/isolate_channel.dart' as sc;
import 'dart:isolate' show SendPort;
import 'dart:async';

import 'chat_service.dart';

/// A generated class that implements the [ChatServiceInterface] via an
/// Isolate.
///
/// Depends upon manually written code in `chat_service.dart` that implements
/// the concrete [ChatService] class.
class ChatServiceIsolate extends ChatServiceInterface {
  final ServiceIsolate _iso;

  ChatServiceIsolate._new(this._iso);

  static void _log(String msg) => print("ChatServiceIsolate: $msg");

  /// Creates a new ChatServiceIsolate.
  static Future<ChatServiceIsolate> create() async =>
      ChatServiceIsolate._new(await ServiceIsolate.spawn(_runIsolate));

  /// Closes the underlying ServiceIsolate.
  Future close() => _iso.close();

  /// The code run inside the isolate.
  ///
  /// The isolate is started with [args] containing a SendPort. It will create a
  /// ChatService and listn on the passed port. Each request from the port is
  /// expected to be an IsolateMessage with either `object` or `streamClosed`
  /// set (in addition to the required `id` and `method`). Based upon the
  /// `method` of the request, a response IsolateMessage with the same `id` and
  /// `method as passed, and either `object`, `exception`, or `streamClosed`
  /// will be returned to the SendPort.
  static void _runIsolate(List<Object> args) async {
    SendPort sPort = args[0] as SendPort;
    ChatServiceInterface svc = await ChatService.create();
    _log("_runIsolate created service");

    final Map<int, StreamController> clientStreamControllers = {};

    sc.IsolateChannel channel = sc.IsolateChannel.connectSend(sPort);
    channel.stream.listen(
      (reqData) {
        if (reqData is! IsolateMessage) {
          throw "_runIsolate.listen got unexpected $reqData";
        }
        _log("_runIsolate.listen got $reqData");

        void onData(Object data) {
          _log("_runIsolate.listen.${reqData.method} response to sink");
          channel.sink.add(reqData.add(object: data));
        }

        void onError(error) {
          _log("_runIsolate.listen.${reqData.method} error $error");
          channel.sink.add(reqData.add(exception: error));
        }

        void onDone() {
          _log("_runIsolate.listen.${reqData.method} onDone");
          channel.sink.add(reqData.add(streamClosed: true));
        }

        try {
          switch (reqData.method) {
            case "/Chat.JoinChannel":
              svc
                  .joinChannel(reqData.object! as JoinChannelRequest)
                  .then(onData, onError: onError);
              break;
            case "/Chat.ObserveChannel":
              svc
                  .observeChannel(reqData.object! as ObserveChannelRequest)
                  .listen(onData, onError: onError, onDone: onDone);
              break;
            case "/Chat.SendStatus":
              {
                StreamController<StatusMessage> controller;
                if (!clientStreamControllers.containsKey(reqData.id)) {
                  controller = StreamController<StatusMessage>();
                  clientStreamControllers[reqData.id] = controller;
                  svc
                      .sendStatus(controller.stream)
                      .then(onData, onError: onError);
                } else {
                  controller = clientStreamControllers[reqData.id]!
                      as StreamController<StatusMessage>;
                }
                if (reqData.streamClosed ?? false) {
                  controller.close().then((v) {
                    clientStreamControllers.remove(reqData.id);
                  }, onError: onError);
                } else {
                  controller.sink.add(reqData.object! as StatusMessage);
                }
              }
              break;
            case "/Chat.Interact":
              {
                StreamController<InteractRequest> controller;
                if (!clientStreamControllers.containsKey(reqData.id)) {
                  controller = StreamController<InteractRequest>();
                  clientStreamControllers[reqData.id] = controller;
                  svc
                      .interact(controller.stream)
                      .listen(onData, onError: onError, onDone: onDone);
                } else {
                  controller = clientStreamControllers[reqData.id]!
                      as StreamController<InteractRequest>;
                }
                if (reqData.streamClosed ?? false) {
                  controller.close().then((v) {
                    clientStreamControllers.remove(reqData.id);
                  }, onError: onError);
                } else {
                  controller.sink.add(reqData.object! as InteractRequest);
                }
              }
              break;
            default:
              onError(
                  "_runIsolate.listen got unexpected method " + reqData.method);
          }
        } catch (e) {
          // The StackTrace object can't go over the Isolate.
          onError(e.toString());
        }
      },
      onError: (error) {
        _log("_runIsolate.listen error $error");
        channel.sink.addError(error);
      },
      onDone: () {
        _log("_runIsolate.listen done");
      },
    );
  }

  @override
  Future<JoinChannelResponse> joinChannel(JoinChannelRequest request) async =>
      await _iso.request("/Chat.JoinChannel", request) as JoinChannelResponse;

  @override
  Stream<NickMessage> observeChannel(ObserveChannelRequest request) => _iso
      .serverStream("/Chat.ObserveChannel", request)
      .map((obj) => obj as NickMessage);

  @override
  Future<StreamStatusResponse> sendStatus(Stream<StatusMessage> stream) async =>
      await _iso.clientStream("/Chat.SendStatus", stream)
          as StreamStatusResponse;

  @override
  Stream<NickMessage> interact(Stream<InteractRequest> stream) => _iso
      .bidiStream("/Chat.Interact", stream)
      .map((obj) => obj as NickMessage);
}
