import 'dart:io';


import 'package:chatty/data/vos/chat_vo.dart';
import 'package:chatty/data/vos/user_vo.dart';

import '../vos/news_feed_vo.dart';

abstract class SocialModel {
  Stream<List<NewsFeedVO>> getNewsFeed();
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId);
  Future<void> addNewPost(String description, List<File>? imageFile, String profileUrl);
  // Future<void> addNewPost(String description);
  // Stream<List<UserVO>>? getChattedContacts(List<String> idList, String currUserId);
  Future<void> editPost(NewsFeedVO newsFeed, List<File>? imageFile);
  Future<void> deletePost(int postId);
  Stream<List<UserVO>> getCurrentContacts(String currUserId);
  Stream<UserVO>? getUserById(String currUserId);
  // Future<void> editProfile(UserVO users);
  Future<void> addNewContact(String currUserId, UserVO user) ;



}
