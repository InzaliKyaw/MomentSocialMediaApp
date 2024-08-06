import 'package:flutter/material.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/social_model.dart';
import '../data/model/social_model_impl.dart';
import '../data/vos/user_vo.dart';

class ContactBloc extends ChangeNotifier{
  String currUserId = "";
  final SocialModel _mSocialModel = SocialModelImpl();
  List<UserVO> getAllContactList = [];
  bool isDisposed = false;
  UserVO? addedUserVO;
  UserVO? currUserVO;


  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  ContactBloc(){
    currUserId = _mAuthenticationModel.getLoggedInUser().id!;
    _mSocialModel.getCurrentContacts(currUserId).listen((contacts) {
      getAllContactList = contacts;
      if(!isDisposed){
        notifyListeners();
      }
    });
  }

  Future onAddContact(String addedContactId){
    /// New Contact is added to the current User's Contact
    _mSocialModel.getUserById(addedContactId)?.listen((userVO){
      addedUserVO = userVO;
      if (!isDisposed) {
        notifyListeners();
      }
    });
    return _mSocialModel.addNewContact(currUserId, addedUserVO!) ;
  }

  Future onAddContactToOtherUser(String addedContactId){
    /// Current User info is added to the Other User's Contact list
    _mSocialModel.getUserById(currUserId)?.listen((userVO){
      currUserVO = userVO;
      if (!isDisposed) {
        notifyListeners();
      }
    });
    return _mSocialModel.addNewContact( addedContactId, currUserVO!) ;
  }


  /// Widget dispose() lote tae achain phan yin error tat mhr mho
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}