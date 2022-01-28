/// REMOVE THIS TEXT: Edit this file and flesh out the service
import "../generated/chat_service.interface.dart";
export "../generated/chat_service.interface.dart";
export "../generated/chat_service.isolate.dart";

/// A simple chat service.
class ChatService extends ChatServiceInterface {
  final Map<String, String> _nickStatus = {};

  /// Creates a new service.
  static Future<ChatServiceInterface> create(ChatServiceConfig config) async {
    return ChatService();
  }

  @override
  Future<JoinChannelResponse> joinChannel(JoinChannelRequest request) async {
    return JoinChannelResponse(
      topic: "Example topic",
      nick: ["Sarah", "Emma", "Luca"],
    );
  }

  @override
  Stream<NickMessage> observeChannel(ObserveChannelRequest request) {
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
