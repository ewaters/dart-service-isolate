import 'dart:async';

import "../generated/chat_service.interface.dart";
import "../generated/chat_service.pb.dart";
export "../generated/chat_service.interface.dart";
export "../generated/chat_service.isolate.dart";
export "../generated/chat_service.pb.dart";

/// A simple chat service.
class ChatService extends ChatServiceInterface {
  final Map<String, String> _nickStatus = {};
  int _cancelledObservations = 0;

  /// Creates a new service.
  static Future<ChatServiceInterface> create(ChatServiceConfig config) async {
    return ChatService();
  }

  /// Close the service.
  @override
  Future<void> close() async {}

  @override
  Future<JoinChannelResponse> joinChannel(JoinChannelRequest request) async {
    if (request.nick == 'cancel-count') {
      return JoinChannelResponse(topic: '$_cancelledObservations');
    }
    return JoinChannelResponse(
      topic: "Example topic",
      nick: ["Sarah", "Emma", "Luca"],
    );
  }

  @override
  Stream<NickMessage> observeChannel(ObserveChannelRequest request) {
    if (request.channelName == 'slow') {
      Timer? timer;
      late final StreamController<NickMessage> controller;
      controller = StreamController<NickMessage>(
        onListen: () {
          controller.add(NickMessage(msg: 'first'));
          timer = Timer.periodic(const Duration(milliseconds: 20), (_) {
            controller.add(NickMessage(msg: 'later'));
          });
        },
        onCancel: () {
          timer?.cancel();
          _cancelledObservations++;
        },
      );
      return controller.stream;
    }
    return Stream.fromIterable(<NickMessage>[
      NickMessage(
          timeSec: 1,
          nick: "Sarah",
          msg: "Emma, how's the weather in Switzerland?"),
      NickMessage(timeSec: 8, nick: "Emma", msg: "Very sunny today"),
    ]);
  }

  @override
  Future<StreamStatusResponse> sendStatus(Stream<StatusMessage> stream) async {
    int count = 0;
    await for (final msg in stream) {
      _nickStatus[msg.nick] = msg.status;
      count++;
    }
    return StreamStatusResponse(count: count);
  }

  @override
  Stream<NickMessage> interact(Stream<InteractRequest> stream) async* {
    int timeSec = 10;
    await for (final msg in stream) {
      yield NickMessage(
        timeSec: timeSec++,
        nick: "Luca",
        msg: "You said '${msg.msg}'? I agree!",
      );
    }
  }
}
