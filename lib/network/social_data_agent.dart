import 'dart:io';

import '../data/vos/chat_vo.dart';
import '../data/vos/news_feed_vo.dart';
import '../data/vos/user_vo.dart';



abstract class SocialDataAgent {
  /// News Feed
  Stream<List<NewsFeedVO>> getNewsFeed();
  Future<void> addNewPost(NewsFeedVO newPost);
  Future<void> deletePost(int postId);
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId);
  Future<String> uploadFileToFirebase(File image);


  /// Authentication
  Future registerNewUser(UserVO newUser);
  /// Login solely works with Authentication API
  Future login(String email, String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();

  /// Contacts
  Stream<List<UserVO>> getContacts(String currUserId);
  Stream<UserVO>? getUserById(String currUserId);
  Future<void> addNewContact(String curUserId,UserVO user) ;
}
