import 'dart:io';


import 'package:chatty/data/vos/chat_vo.dart';
import 'package:chatty/data/vos/message_vo.dart';
import 'package:chatty/network/chat_data_agent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

import '../data/vos/user_vo.dart';

/// Database Paths
const usersPath = "users";

/// File Upload References
const fileUploadRef = "uploads";

class RealtimeDatabaseDataAgentImpl extends ChatDataAgent {
  static final RealtimeDatabaseDataAgentImpl _singleton =
      RealtimeDatabaseDataAgentImpl._internal();

  factory RealtimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealtimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.ref();

  /// Storage
  // var firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  /// Child level hti access lote loc ya
  @override
  Stream<List<MessageVO>?> getChatMessages(String senderUserId, String receiverId) {
      return databaseRef.child('$senderUserId/$receiverId/messages').onValue.map((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        return data.values.map<MessageVO>((element) {
          return MessageVO.fromJson(Map<String, dynamic>.from(element));
        }).toList();
      });
  }

  Stream<List<String>?> getChattedContacts(String currUserId) {
    return databaseRef.child(currUserId).onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final chattedContacts = data.keys.toList();
      // List<String>? strList = [];
      return chattedContacts.map((contacts)=> contacts.toString()).toList();
    });
  }

  /* Add message to user node
 @FirstParam: Root Node
 @SecondParam: Sub Rood Node
 @ThirdParam: MessageVO
 Message is needed to add for both User
 */
  @override
  Future<void> addNewMessage(String currUserId, String receiverId,MessageVO messageVO){
    String uuid = const Uuid().v4(); // Generate a random UUID
    return databaseRef
        .child(currUserId)
        .child(receiverId)
        .child("messages")
        .child(uuid)
        .set(messageVO.toJson());
  }


  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  bool isLoggedIn(){
    return auth.currentUser != null;
  }

  @override
  UserVO getLoggedInUser(){
    return UserVO(
      id: auth.currentUser?.uid,
      phone: auth.currentUser?.phoneNumber,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
    );
  }

  @override
  Future logOut(){
    return auth.signOut();
  }
}
