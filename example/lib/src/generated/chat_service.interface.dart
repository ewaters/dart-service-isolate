// Generated code: do not modify
// ignore_for_file: public_member_api_docs, always_use_package_imports
import 'chat_service.pb.dart' as pb0;

abstract class ChatServiceInterface {
  Future<void> close();
  Future<pb0.JoinChannelResponse> joinChannel(pb0.JoinChannelRequest request);
  Stream<pb0.NickMessage> observeChannel(pb0.ObserveChannelRequest request);
  Future<pb0.StreamStatusResponse> sendStatus(Stream<pb0.StatusMessage> stream);
  Stream<pb0.NickMessage> interact(Stream<pb0.InteractRequest> stream);
}
