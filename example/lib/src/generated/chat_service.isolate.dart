// Generated code: do not modify
// ignore_for_file: public_member_api_docs, always_use_package_imports
import 'package:service_isolate/service_isolate.dart';
import 'package:stream_channel/isolate_channel.dart' as sc;

import 'dart:isolate' show SendPort;
import 'dart:async';

import '../services/chat_service.dart';
import 'chat_service.pb.dart' as pb0;

void _log(String msg) => print('ChatServiceIsolate: $msg');

/// A generated class that implements the [ChatServiceInterface] via an
/// Isolate.
///
/// Depends upon manually written code in
/// `../services/chat_service.dart` that implements
/// the concrete [ChatService] class.
class ChatServiceIsolate extends ChatServiceInterface {
  final ServiceIsolate _iso;
  ChatServiceIsolate._new(this._iso);

  /// Creates a new ChatServiceIsolate.
  static Future<ChatServiceIsolate> create(
    pb0.ChatServiceConfig config,
  ) async => ChatServiceIsolate._new(
    await ServiceIsolate.spawn(_runIsolate, firstMessage: config),
  );

  /// Closes the underlying ServiceIsolate.
  @override
  Future close() => _iso.close();

  @override
  Future<pb0.JoinChannelResponse> joinChannel(pb0.JoinChannelRequest request) =>
      _iso
          .request('/Chat.JoinChannel', request)
          .then((obj) => obj as pb0.JoinChannelResponse);
  @override
  Stream<pb0.NickMessage> observeChannel(pb0.ObserveChannelRequest request) =>
      _iso
          .serverStream('/Chat.ObserveChannel', request)
          .map((obj) => obj as pb0.NickMessage);
  @override
  Future<pb0.StreamStatusResponse> sendStatus(
    Stream<pb0.StatusMessage> stream,
  ) => _iso
      .clientStream('/Chat.SendStatus', stream)
      .then((obj) => obj as pb0.StreamStatusResponse);
  @override
  Stream<pb0.NickMessage> interact(Stream<pb0.InteractRequest> stream) => _iso
      .bidiStream('/Chat.Interact', stream)
      .map((obj) => obj as pb0.NickMessage);
}

void _runIsolate(List<Object> args) async {
  final svc = await ChatService.create(args[1] as pb0.ChatServiceConfig);
  final Map<int, StreamController> clientStreamControllers = {};
  final channel = sc.IsolateChannel.connectSend(args[0] as SendPort);
  channel.stream.listen(
    (reqData) {
      final helper = ServiceIsolateHelper(
        channel,
        reqData,
        clientStreamControllers,
      );
      try {
        switch (reqData.method) {
          case '/Chat.JoinChannel':
            svc
                .joinChannel(reqData.object! as pb0.JoinChannelRequest)
                .then(helper.onData, onError: helper.onError);
            break;
          case '/Chat.ObserveChannel':
            svc
                .observeChannel(reqData.object! as pb0.ObserveChannelRequest)
                .listen(
                  helper.onData,
                  onError: helper.onError,
                  onDone: helper.onDone,
                );
            break;
          case '/Chat.SendStatus':
            {
              if (!clientStreamControllers.containsKey(reqData.id)) {
                final controller = StreamController<pb0.StatusMessage>();
                clientStreamControllers[reqData.id] = controller;
                svc
                    .sendStatus(controller.stream)
                    .then(helper.onData, onError: helper.onError);
              }
              helper.handleClientStream();
            }
            break;
          case '/Chat.Interact':
            {
              if (!clientStreamControllers.containsKey(reqData.id)) {
                final controller = StreamController<pb0.InteractRequest>();
                clientStreamControllers[reqData.id] = controller;
                svc
                    .interact(controller.stream)
                    .listen(
                      helper.onData,
                      onError: helper.onError,
                      onDone: helper.onDone,
                    );
              }
              helper.handleClientStream();
            }
            break;
          default:
            helper.onError(
              '_runIsolate.listen got unexpected method ' + reqData.method,
            );
        }
      } catch (e) {
        helper.onError(e.toString());
      }
    },
    onError: (error) {
      _log('_runIsolate.listen error $error');
      channel.sink.addError(error);
    },
    onDone: () {
      _log('_runIsolate.listen done');
    },
  );
}
