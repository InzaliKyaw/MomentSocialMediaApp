import 'package:chatty/data/vos/chat_vo.dart';
import 'package:chatty/data/vos/message_vo.dart';

abstract class ChatModel{
  Stream<List<MessageVO>?> getChatMessages(String senderId, String receiverId);
  Stream<List<String>?> getChattedContacts(String currUserId);
  Future<void> addNewMessage(String currUserId, String receiverId,MessageVO messageVO);

}