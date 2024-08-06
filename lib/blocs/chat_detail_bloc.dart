
import 'dart:async';

import 'package:chatty/data/vos/user_vo.dart';
import 'package:flutter/material.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/chat_model.dart';
import '../data/model/chat_model_impl.dart';
import '../data/model/social_model.dart';
import '../data/model/social_model_impl.dart';
import '../data/vos/message_vo.dart';

class ChatDetailBloc extends ChangeNotifier{
  List<MessageVO>? getChatList;
  final ChatModel _mChatModel = ChatModelImpl();
  bool isDisposed = false;
  String currUserId = "";
  String receiverId = "";
  UserVO? currUserVO;

  /// BookItem List
  StreamSubscription? _messageSubscription;

  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();
  final SocialModel _mSocialModel = SocialModelImpl();



  ChatDetailBloc(){
    currUserId = _mAuthenticationModel.getLoggedInUser().id!;
    _mSocialModel.getUserById(currUserId)?.listen((userVO){
      currUserVO = userVO;
      if (!isDisposed) {
        notifyListeners();
      }
    });

    // _mChatModel.getChatMessages(currUserId,"komRSh45FnQmZ2JcDqqWL9WLZNj1").listen((chatList) {
    //   getChatList = chatList;
    //   getChatList?.sort((a,b) => a.timestamp!.compareTo(b.timestamp as num)); // You can also write a['value1'] - b['value1']
    //   if (!isDisposed) {
    //     notifyListeners();
    //   }
    // });
  }

  void getChatMessages( String receiverId){
    _messageSubscription?.cancel();
    _messageSubscription = _mChatModel.getChatMessages(currUserId,receiverId).listen((chatList) {
      getChatList = chatList;
      getChatList?.sort((a,b) => a.timestamp!.compareTo(b.timestamp as num)); // You can also write a['value1'] - b['value1']
      if (!isDisposed) {
        notifyListeners();
      }
    });
  }

  Future addNewMessage(String currUserId, String receiverId, MessageVO messageVO) {
    return _mChatModel.addNewMessage(currUserId, receiverId, messageVO);
  }

  void onReceiverIdChange(String receiverId) {
    this.receiverId = receiverId;
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    isDisposed = true;
    super.dispose();
  }


}