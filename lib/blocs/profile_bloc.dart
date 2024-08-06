
import 'package:chatty/data/model/social_model_impl.dart';
import 'package:chatty/data/vos/user_vo.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/social_model.dart';

class ProfileBloc extends ChangeNotifier{
  String currUserId = "";
  UserVO? profileVO;
  bool isDisposed = false;
  String email = "";
  String password = "";
  String userName = "";
  String userGender = "";



  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();
  final SocialModel _mSocialModel = SocialModelImpl();

  ProfileBloc(){
  currUserId = _mAuthenticationModel.getLoggedInUser().id!;
  _mSocialModel.getUserById(currUserId)?.listen((userVO){
    profileVO = userVO;
    if (!isDisposed) {
      notifyListeners();
    }
  });
 }

  // Future<dynamic> onTapEditProfile(){
  //   if(profileVO != null){
  //     _mSocialModel.editProfile(profileVO!);
  //   }else{
  //     return Future.error("Error");
  //   }
  // }


  void onEmailChanged(String email) {
    this.email = email;
  }

  void onUserNameChanged(String userName) {
    this.userName = userName;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void onGenderChanged(String userGender) {
    this.userGender = userGender;
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}