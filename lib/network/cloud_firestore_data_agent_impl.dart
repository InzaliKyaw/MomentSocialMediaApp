import 'dart:io';

import 'package:chatty/data/vos/chat_vo.dart';
import 'package:chatty/network/social_data_agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../data/vos/news_feed_vo.dart';
import '../data/vos/user_vo.dart';


/// News Feed Collection
const newsFeedCollection = "newsfeed";
const usersCollection = "users";
const fileUploadRef = "uploads";

class CloudFireStoreDataAgentImpl extends SocialDataAgent {
  /// FireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> addNewContact(String curUserId,UserVO user) {
    return _fireStore
        .collection(usersCollection)
        .doc(curUserId)
        .collection("contacts")
        .doc(user.id.toString())
        .set(user.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(postId.toString())
        .delete();
  }

  /// newsfeed ko querySnapShot anay nae ya tal
  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    /// snapshots => querySnapShot => querySnapShot.docs => List<querySnapShot> => data() => List<Map<String, dynamic>>
    /// NewsfeedVO.fromJson => List<NewsfeedVO>
    return _fireStore
        .collection(newsFeedCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<NewsFeedVO>((document) {
        return NewsFeedVO.fromJson(document.data());
      }).toList();
    });
  }

  /// Get ka one time emit loc Future return pyan
  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(newsFeedId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) =>
            NewsFeedVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Stream<List<UserVO>> getContacts(String currUserId) {
    return _fireStore
        .collection(usersCollection)
        .doc(currUserId)
        .collection("contacts")
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<UserVO>((document) {
        return UserVO.fromJson(document.data());
      }).toList();
    });


  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return FirebaseStorage.instance
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) =>
            credential.user?..updateDisplayName(newUser.userName))
        .then((user) {
      newUser.id = user?.uid ?? "";
      addNewUser(newUser);
    });
  }

  Future<void> addNewUser(UserVO newUser) {
    return _fireStore
        .collection(usersCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }



  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
      phone: auth.currentUser?.phoneNumber,
      profilePicture: auth.currentUser?.photoURL
    );
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Stream<UserVO>? getUserById(String currUserId) {
    return _fireStore
        .collection(usersCollection)
        .doc(currUserId)
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) =>
        UserVO.fromJson(documentSnapShot.data()!));
  }


}
