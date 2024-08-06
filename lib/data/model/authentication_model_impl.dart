import 'package:chatty/network/social_data_agent.dart';

import '../../network/cloud_firestore_data_agent_impl.dart';
import '../vos/user_vo.dart';
import 'authentication_model.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton =
      AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();

  // SocialDataAgent mDataAgent = RealtimeDatabaseDataAgentImpl();

  SocialDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  Future<void> register(String email, String userName, String password, String phone, String birthday, String gender) {
    return craftUserVO(email, userName,password, phone, birthday, gender)
        .then((user) => mDataAgent.registerNewUser(user));
  }

  Future<UserVO> craftUserVO(String email, String userName, String password, String phone, String birthday, String gender) {
    var newUser = UserVO(
      id: "",
      userName: userName,
      email: email,
      password: password,
      phone: phone,
      birthday: birthday,
      gender: gender
    );
    return Future.value(newUser);
  }

  @override
  UserVO getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }

  @override
  Stream<UserVO>? getUserById(String currUserId) {
    return mDataAgent.getUserById(currUserId);
  }
}
