import 'package:chatty/data/vos/chat_vo.dart';
import 'package:chatty/data/vos/message_vo.dart';

import '../data/vos/user_vo.dart';

abstract class ChatDataAgent{
  Stream<List<MessageVO>?> getChatMessages(String senderUserId, String receiverId);
  Stream<List<String>?> getChattedContacts(String currUserId);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future<void> addNewMessage(String currUserId, String receiverId,MessageVO messageVO);
}