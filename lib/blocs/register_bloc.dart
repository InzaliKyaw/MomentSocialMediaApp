
import 'package:flutter/foundation.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';


class RegisterBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String email = "";
  String password = "";
  String userName = "";
  // String birthday = "";
  String userGender = "";
  bool isDisposed = false;

  /// Model
  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapRegister(String phNo, String birthday) {
    _showLoading();
    return _model
        .register(email, userName, password,  phNo,  birthday, userGender)
        .whenComplete(() => _hideLoading());
  }

  void onEmailChanged(String email) {
    this.email = email;
  }

  void onUserNameChanged(String userName) {
    this.userName = userName;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  // void onBirthdayChanged(String birthday) {
  //   this.birthday = birthday;
  // }

  void onGenderChanged(String userGender) {
    this.userGender = userGender;
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
