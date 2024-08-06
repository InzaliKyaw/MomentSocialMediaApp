import 'package:chatty/data/model/chat_model.dart';
import 'package:chatty/data/model/chat_model_impl.dart';
import 'package:flutter/material.dart';
import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/social_model.dart';
import '../data/model/social_model_impl.dart';
import '../data/vos/user_vo.dart';

class ChatBloc extends ChangeNotifier {
  List<String> getChattedContactIdList = [];
  List<UserVO> getAllContactList = [];
  List<UserVO> getContactList = [];
  String currUserId = "";
  List<UserVO> chattedContactList = [];

  /// Models
  final ChatModel _mChatModel = ChatModelImpl();
  final SocialModel _mSocialModel = SocialModelImpl();
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();


  bool isDisposed = false;

  ChatBloc() {
    currUserId = _authenticationModel.getLoggedInUser().id ?? "";

    /// Get Current's user chatted contact in id:String List
    _mChatModel.getChattedContacts(currUserId).listen((chattedContact) {
      getChattedContactIdList = chattedContact ?? [];
      if (!isDisposed) {
        notifyListeners();
      }
    });

    /// Get Chatted contact list's Full Information UserVO by matching it with contact and get
    /// it from Contact List
    _mSocialModel.getCurrentContacts(currUserId).listen((contacts) {
      getAllContactList = contacts;
      if(!isDisposed){
        notifyListeners();
      }
    });
      // _mSocialModel.getChattedContacts(idList, currUserId).listen((){
    //
    // })
    // _sendAnalyticsData();
  }

  void onChattedContactList(List<UserVO> chattedContactList) {
    this.chattedContactList = chattedContactList;
    // _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
  /// Widget dispose() lote tae achain phan yin error tat mhr mho
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
