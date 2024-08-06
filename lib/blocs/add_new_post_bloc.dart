import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/social_model.dart';
import '../data/model/social_model_impl.dart';
import '../data/vos/news_feed_vo.dart';
import '../data/vos/user_vo.dart';
import 'package:http/http.dart' as http;


class AddNewPostBloc extends ChangeNotifier {
  /// State
  String newPostDescription = "";
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isLoading = false;
  UserVO? _loggedInUser;

  Color themeColor = Colors.black;

  /// Image
  List<File> chosenImageFile = [];

  /// For Edit Mode
  bool isInEditMode = false;
  String userName = "";
  String profilePicture = "";
  NewsFeedVO? mNewsFeed;
  UserVO? currUserVO;
  String? currUserProfile;
  String? currUserId;


  /// Model
  final SocialModel _model = SocialModelImpl();

   final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  /// Remote Configs
  //  final FirebaseRemoteConfigService _firebaseRemoteConfig = FirebaseRemoteConfigService();

  AddNewPostBloc({int? newsFeedId}) {
    _loggedInUser = _authenticationModel.getLoggedInUser();
    currUserId = _authenticationModel.getLoggedInUser().id;
    if (newsFeedId != null) {
      isInEditMode = true;
      _prepopulateDataForEditMode(newsFeedId);
    } else {
      _prepopulateDataForAddNewPost();
    }

    String currUser = _authenticationModel.getLoggedInUser().id ?? "";
    _model.getUserById(currUser)?.listen((userVO){
      currUserVO = userVO;
      currUserProfile = currUserVO?.profilePicture ?? null;
      if (!isDisposed) {
        notifyListeners();
      }
    });
    /// Firebase
    //  _sendAnalyticsData(addNewPostScreenReached, null);
    //  _getRemoteConfigAndChangeTheme();
  }


  // void _getRemoteConfigAndChangeTheme() {
  //   themeColor = _firebaseRemoteConfig.getThemeColorFromRemoteConfig();
  //   _notifySafely();
  // }


  void _prepopulateDataForAddNewPost() {
    userName = _loggedInUser?.userName ?? "";
    profilePicture =
    "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    _notifySafely();
  }

  void _prepopulateDataForEditMode(int newsFeedId) {
    _model.getNewsFeedById(newsFeedId).listen((newsFeed) {
      /// State variable htal ko htae
      userName = newsFeed.userName ?? "";
      profilePicture = newsFeed.profilePicture ?? "";
      newPostDescription = newsFeed.description ?? "";
      mNewsFeed = newsFeed;
      _notifySafely();
    });
  }

  // Future<File> urlToFile(String imageUrl) async {
  //   // generate random number.
  //       var rng = new Random();
  //   // get temporary directory of device.
  //       Directory tempDir = await getTemporaryDirectory();
  //   // get temporary path from temporary directory.
  //       String tempPath = tempDir.path;
  //   // create a new file in temporary path with random file name.
  //       File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
  //   // call http.get method and pass imageUrl into it to get response.
  //       http.Response response = await http.get(imageUrl);
  //   // write bodyBytes received in response to file.
  //       await file.writeAsBytes(response.bodyBytes);
  //   // now return the file which is created with random name in
  //   // temporary directory and image bytes from response is written to // that file.
  //   return file;
  // }


  void onImageChosen(List<File> imageFile) {
    chosenImageFile = imageFile.toList();
    _notifySafely();
  }

  void onTapDeleteImage(File imgFile) {
     chosenImageFile.remove(imgFile);
     this.chosenImageFile = chosenImageFile;
    _notifySafely();
  }

  void onNewPostTextChanged(String newPostDescription) {
    this.newPostDescription = newPostDescription;
  }
  // void getCurrentUser(String currUser){
  //   /// New Contact is added to the current User's Contact
  //
  // }


  Future onTapAddNewPost( String profileUrl) {
    if (newPostDescription.isEmpty) {
      isAddNewPostError = true;
      _notifySafely();
      return Future.error("Error");
    } else {
      isLoading = true;
      _notifySafely();
      isAddNewPostError = false;
      if (isInEditMode) {
        return _editNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
        //   // _sendAnalyticsData(
        //   //     editPostAction, {postId: mNewsFeed?.id.toString() ?? ""});
        });
      } else {
        return _createNewNewsFeedPost(profileUrl).then((value) {
          isLoading = false;
          _notifySafely();
        //   // _sendAnalyticsData(addNewPostAction, null);
        });
      }
    }
  }

    void _notifySafely() {
      if (!isDisposed) {
        notifyListeners();
      }
    }


    Future<dynamic> _editNewsFeedPost() {
      mNewsFeed?.description = newPostDescription;
      if (mNewsFeed != null) {
        return _model.editPost(mNewsFeed!, chosenImageFile);
      } else {
        return Future.error("Error");
      }
    }

    Future<void> _createNewNewsFeedPost(String profileUrl) {
      return _model.addNewPost(newPostDescription, chosenImageFile, profileUrl);
    }


    /// Analytics
    // void _sendAnalyticsData(String name, Map<String, String>? parameters) async {
    //   await FirebaseAnalyticsTracker().logEvent(name, parameters);
    // }

    @override
    void dispose() {
      super.dispose();
      isDisposed = true;
    }
  }



