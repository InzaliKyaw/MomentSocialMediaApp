
import '../vos/user_vo.dart';

abstract class AuthenticationModel {
  Future<void> login(String email, String password);

  Future<void> register(String email, String userName, String password, String phone, String birthday, String gender);

  bool isLoggedIn();

  UserVO getLoggedInUser();

  Stream<UserVO>? getUserById(String currUserId);

  Future<void> logOut();
}
