import 'package:example/src/services/chat_service.dart';
import 'package:test/test.dart';

void main() {
  Future _testService(ChatServiceInterface chat) async {
    final joinResp = await chat.joinChannel(JoinChannelRequest(
      nick: "tester",
      channelName: "Friends",
    ));
    expect(joinResp.topic, equals("Example topic"));

    final observeMsgs =
        await chat.observeChannel(ObserveChannelRequest()).toList();
    expect(observeMsgs.length, equals(2));
    expect(observeMsgs[1].msg, equals("Very sunny today"));

    final statusResp = await chat.sendStatus(Stream.fromIterable([
      StatusMessage(nick: "tester", status: "away"),
      StatusMessage(nick: "tester", status: "online"),
    ]));
    expect(statusResp.count, equals(2));

    final interactMsgs = await chat
        .interact(Stream.fromIterable([
          InteractRequest(channelName: "Friends", msg: "Hi there!"),
        ]))
        .toList();
    expect(interactMsgs.length, equals(1));
    expect(interactMsgs[0].msg, equals("You said 'Hi there!'? I agree!"));
  }

  final config = ChatServiceConfig();

  test('Local instance', () async {
    final chat = await ChatService.create(config);
    await _testService(chat);
  });

  test('Isolate instance', () async {
    final chat = await ChatServiceIsolate.create(config);
    await _testService(chat);
    await chat.close();
  });
}
