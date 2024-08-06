
import 'package:flutter/foundation.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/social_model.dart';
import '../data/model/social_model_impl.dart';
import '../data/vos/news_feed_vo.dart';

class NewsFeedBloc extends ChangeNotifier {
  List<NewsFeedVO>? newsFeed;

  /// Remote Configs
  /// Models
  final SocialModel _mSocialModel = SocialModelImpl();

  bool isDisposed = false;

  NewsFeedBloc() {
    _mSocialModel.getNewsFeed().listen((newsFeedList) {
      newsFeed = newsFeedList;
      // newsFeed?.sort((a,b) => a.!.compareTo(b.timestamp as num)); // You can also write a['value1'] - b['value1']

      if (!isDisposed) {
        notifyListeners();
      }
    });
     // _sendAnalyticsData();
  }

  // void _sendAnalyticsData() async {
  //   /// FirebaseAnalyticsTracker() ka singleton mho ta khr htal use loc ya
  //   /// each post ma hote thay loc
  //   await FirebaseAnalyticsTracker().logEvent(homeScreenReached, null);
  // }

  void onTapDeletePost(int postId) async {
    await _mSocialModel.deletePost(postId);
  }



  /// Widget dispose() lote tae achain phan yin error tat mhr mho
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
