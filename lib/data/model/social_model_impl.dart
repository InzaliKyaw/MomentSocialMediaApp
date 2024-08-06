import 'dart:io';

import 'package:chatty/data/model/social_model.dart';
import 'package:chatty/data/vos/chat_vo.dart';
import 'package:chatty/data/vos/user_vo.dart';
import 'package:chatty/network/cloud_firestore_data_agent_impl.dart';
import '../../network/social_data_agent.dart';
import '../vos/news_feed_vo.dart';
import 'authentication_model.dart';
import 'authentication_model_impl.dart';


class SocialModelImpl extends SocialModel {
  static final SocialModelImpl _singleton = SocialModelImpl._internal();

  factory SocialModelImpl() {
    return _singleton;
  }

  SocialModelImpl._internal();

  //SocialDataAgent mDataAgent = RealtimeDatabaseDataAgentImpl();
  SocialDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  /// Other Models
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Future<void> addNewPost(String description, List<File>? imageFile, String profileUrl) {
    if (imageFile != null) {
      List<String> imgList = [];
      if (imageFile.length > 1) {
        for (var file in imageFile) {
          mDataAgent.uploadFileToFirebase(file)
              .then((downloadUrl) => imgList.add(downloadUrl));
        }
        return mDataAgent
            .uploadFileToFirebase(imageFile.first)
            .then((downloadUrl) => craftNewsFeedVO(description, imgList,profileUrl))
            .then((newPost) => mDataAgent.addNewPost(newPost));
      } else {
         return mDataAgent
               .uploadFileToFirebase(imageFile[0])
               .then((downloadUrl) => craftNewsFeedVO(description, [downloadUrl],profileUrl))
               .then((newPost) => mDataAgent.addNewPost(newPost));
      }
    } else {
      return craftNewsFeedVO(description, [],profileUrl)
          .then((newPost) => mDataAgent.addNewPost(newPost));
    }
  }

  /// Firebase ka imageUrl ko NewsFeedVo htal add lote mal
  Future<NewsFeedVO> craftNewsFeedVO(String description,
      List<String> imageUrl, String profileUrl) {
    var currentMilliseconds = DateTime
        .now()
        .millisecondsSinceEpoch;
    var newPost = NewsFeedVO(
      id: currentMilliseconds,
      userName: _authenticationModel
          .getLoggedInUser()
          .userName,
      postImage: imageUrl,
      description: description,
      profilePicture: profileUrl,
    );
    return Future.value(newPost);
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId) {
    return mDataAgent.getNewsFeedById(newsFeedId);
  }

  @override
  Future<void> editPost(NewsFeedVO newsFeed, List<File>? imageFile) {
    return mDataAgent.addNewPost(newsFeed);
  }

  // @override
  // Future<void> editPost(NewsFeedVO newsFeed, List<File>? imageFile) {
  //   return mDataAgent.addNewPost(newsFeed);
  // }


  @override
  Stream<List<UserVO>> getCurrentContacts(String currUserId) {
    return  mDataAgent.getContacts(currUserId);
  }

  @override
  Stream<UserVO>? getUserById(String currUserId) {
    return mDataAgent.getUserById(currUserId);
  }

  @override
  Future<void> addNewContact(String currUserId, UserVO user) {
    return mDataAgent.addNewContact(currUserId, user);
  }

}