import 'package:chatty/data/model/chat_model.dart';
import 'package:chatty/data/vos/chat_vo.dart';
import 'package:chatty/data/vos/message_vo.dart';
import 'package:chatty/network/chat_data_agent.dart';
import '../../network/real_time_database_data_agent_impl.dart';


class ChatModelImpl extends ChatModel{

  static final ChatModelImpl _singleton =
  ChatModelImpl._internal();

  factory ChatModelImpl() {
    return _singleton;
  }

  ChatModelImpl._internal();

  ChatDataAgent mDataAgent = RealtimeDatabaseDataAgentImpl();

  @override
  Stream<List<MessageVO>?> getChatMessages(String senderUserId, String receiverId) {
    Stream<List<MessageVO>?> messages =  mDataAgent.getChatMessages(senderUserId,receiverId);
    print("MESSAGE ${messages.toString()}");
    return mDataAgent.getChatMessages(senderUserId,receiverId);
  }

  @override
  Stream<List<String>?> getChattedContacts(String currUserId) {
    Stream<List<String>?> messages =  mDataAgent.getChattedContacts(currUserId);
    return mDataAgent.getChattedContacts(currUserId);
  }

  @override
  Future<void> addNewMessage(String currUserId, String receiverId, MessageVO messageVO) {
    return mDataAgent.addNewMessage(currUserId,receiverId,messageVO);
  }


}