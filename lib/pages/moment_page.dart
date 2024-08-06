import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/dimens.dart';
import 'package:chatty/resources/images.dart';
import 'package:chatty/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/news_feed_bloc.dart';
import '../viewitems/news_feed_item_view.dart';
import 'add_new_post_page.dart';


class MomentPage extends StatefulWidget {
  const MomentPage({super.key});

  @override
  State<MomentPage> createState() => _MomentPageState();
}

class _MomentPageState extends State<MomentPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsFeedBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
             SliverAppBar(
             expandedHeight: 100.0,
              floating: false,
              pinned: false,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              flexibleSpace:  FlexibleSpaceBar(
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    children: [
                      const Text(LBL_MOMENT,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontFamily: 'YorkieDEMO',
                      ),),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          _navigateToAddNewPostPage(context);
                        },
                        child: Image.asset(
                          ADD_BUTTON,
                          width: 26,
                          height: 26,
                        ),
                      ),
                    ],
                  ),
                ),

              ),

            ),
            SliverFillRemaining(
              child: Container(
                color: Colors.white,
                child: Consumer<NewsFeedBloc>(
                  builder: (context, bloc, child) => ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: MARGIN_LARGE,
                      horizontal: MARGIN_LARGE,
                    ),
                    itemBuilder: (context, index) {
                      return NewsFeedItemView(
                        mNewsFeed: bloc.newsFeed?[index],
                        onTapDelete: (newsFeedId) {
                          bloc.onTapDeletePost(newsFeedId);
                        },
                        onTapEdit: (newsFeedId) {
                          Future.delayed(const Duration(milliseconds: 1000))
                              .then((value) {
                            _navigateToEditPostPage(context, newsFeedId);
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: MARGIN_XLARGE,
                      );
                    },
                    itemCount: bloc.newsFeed?.length ?? 0,
                  ),
                ),
              ),
            ),

          ]
          ),
      ),
    );
  }

  void _navigateToAddNewPostPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddNewPostPage(),
      ),
    );
  }

  void _navigateToEditPostPage(BuildContext context, int newsFeedId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNewPostPage(
          newsFeedId: newsFeedId,
        ),
      ),
    );
  }
}

