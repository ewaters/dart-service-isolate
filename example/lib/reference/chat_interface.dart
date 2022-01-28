// ignore_for_file: public_member_api_docs
import 'src/generated/chat_service.pb.dart';
export 'src/generated/chat_service.pb.dart';

abstract class ChatServiceInterface {
  Future<JoinChannelResponse> joinChannel(JoinChannelRequest request);

  Stream<NickMessage> observeChannel(ObserveChannelRequest request);

  Future<StreamStatusResponse> sendStatus(Stream<StatusMessage> stream);

  Stream<NickMessage> interact(Stream<InteractRequest> stream);
}
