import 'package:service_isolate/service_isolate.dart';
import 'package:stream_channel/isolate_channel.dart' as sc;
import 'dart:isolate' show SendPort;
import 'dart:async';

import 'chat_service.dart';

void _log(String msg) => print("ChatServiceIsolate: $msg");

/// The code run inside the isolate.
///
/// The isolate is started with [args] containing a SendPort. It will create a
/// ChatService and listn on the passed port. Each request from the port is
/// expected to be an IsolateMessage with either `object` or `streamClosed`
/// set (in addition to the required `id` and `method`). Based upon the
/// `method` of the request, a response IsolateMessage with the same `id` and
/// `method as passed, and either `object`, `exception`, or `streamClosed`
/// will be returned to the SendPort.
void _runIsolate(List<Object> args) async {
  final svc = await ChatService.create();
  final Map<int, StreamController> clientStreamControllers = {};
  final channel = sc.IsolateChannel.connectSend(args[0] as SendPort);
  channel.stream.listen(
    (reqData) {
      final helper =
          ServiceIsolateHelper(channel, reqData, clientStreamControllers);
      try {
        switch (reqData.method) {
          case "/Chat.JoinChannel":
            svc
                .joinChannel(reqData.object! as JoinChannelRequest)
                .then(helper.onData, onError: helper.onError);
            break;
          case "/Chat.ObserveChannel":
            svc.observeChannel(reqData.object! as ObserveChannelRequest).listen(
                helper.onData,
                onError: helper.onError,
                onDone: helper.onDone);
            break;
          case "/Chat.SendStatus":
            {
              if (!clientStreamControllers.containsKey(reqData.id)) {
                final controller = StreamController<StatusMessage>();
                clientStreamControllers[reqData.id] = controller;
                svc
                    .sendStatus(controller.stream)
                    .then(helper.onData, onError: helper.onError);
              }
              helper.handleClientStream();
            }
            break;
          case "/Chat.Interact":
            {
              if (!clientStreamControllers.containsKey(reqData.id)) {
                final controller = StreamController<InteractRequest>();
                clientStreamControllers[reqData.id] = controller;
                svc.interact(controller.stream).listen(helper.onData,
                    onError: helper.onError, onDone: helper.onDone);
              }
              helper.handleClientStream();
            }
            break;
          default:
            helper.onError(
                "_runIsolate.listen got unexpected method " + reqData.method);
        }
      } catch (e) {
        // The StackTrace object can't go over the Isolate.
        helper.onError(e.toString());
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

/// A generated class that implements the [ChatServiceInterface] via an
/// Isolate.
///
/// Depends upon manually written code in `chat_service.dart` that implements
/// the concrete [ChatService] class.
class ChatServiceIsolate extends ChatServiceInterface {
  final ServiceIsolate _iso;
  ChatServiceIsolate._new(this._iso);

  /// Creates a new ChatServiceIsolate.
  static Future<ChatServiceIsolate> create() async =>
      ChatServiceIsolate._new(await ServiceIsolate.spawn(_runIsolate));

  /// Closes the underlying ServiceIsolate.
  Future close() => _iso.close();

  @override
  Future<JoinChannelResponse> joinChannel(JoinChannelRequest request) => _iso
      .request("/Chat.JoinChannel", request)
      .then((obj) => obj as JoinChannelResponse);

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
