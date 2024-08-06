

import 'package:flutter/cupertino.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';

class SettingBloc extends ChangeNotifier{
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  SettingBloc(){

}
  Future onTapLogout() {
    return _mAuthenticationModel.logOut();
  }
}