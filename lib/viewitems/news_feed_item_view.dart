import 'package:chatty/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/vos/news_feed_vo.dart';
import '../resources/dimens.dart';
import '../resources/images.dart';
import '../widgets/profile_image_view.dart';

class NewsFeedItemView extends StatelessWidget {
  final NewsFeedVO? mNewsFeed;
  final Function(int) onTapDelete;
  final Function(int) onTapEdit;

  const NewsFeedItemView({
    Key? key,
    required this.mNewsFeed,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int postImageLength = mNewsFeed?.postImage?.length ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ProfileImageView(
              profileImage: mNewsFeed?.profilePicture ?? "",
            ),
            const SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            NameLocationAndTimeAgoView(
              userName: mNewsFeed?.userName ?? "",
            ),
            const Spacer(),
            MoreButtonView(
              onTapDelete: () {
                onTapDelete(mNewsFeed?.id ?? 0);
              },
              onTapEdit: () {
                onTapEdit(mNewsFeed?.id ?? 0);
              },
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        PostDescriptionView(
          description: mNewsFeed?.description ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Visibility(
          visible: (postImageLength == 1 ),
          child: PostImageView(
            postImage: mNewsFeed?.postImage![0] ?? "",
           imgWidth:  double.infinity
          ),
        ),
        Visibility(
          visible:  postImageLength > 1 ,
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postImageLength,
                itemBuilder: (context,index){
                  String? postImage = mNewsFeed?.postImage![index];
                  return PostImageView(postImage: postImage ?? "" ,imgWidth: 180,);
                }),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        const Row(
          children: [
            Text(
              "See Comments",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Icon(
              Icons.mode_comment_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.grey,
            )
          ],
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String description;

  const PostDescriptionView({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: TEXT_REGULAR,
        color: Colors.black,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  final String postImage;
  final double imgWidth;


  const PostImageView({
    Key? key,
    required this.postImage,
    required this.imgWidth

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
        child: FadeInImage(
          height: 200,
          width: imgWidth,
          placeholder: const NetworkImage(
            NETWORK_IMAGE_POST_PLACEHOLDER,
          ),
          image: NetworkImage(
            postImage,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  const MoreButtonView({
    Key? key,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: const EdgeInsets.only(bottom: 14),
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.grey,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            onTapEdit();
          },
          child: const Text("Edit"),
          value: 1,
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          child: const Text("Delete"),
          value: 2,
        )
      ],
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  final String userName;

  const NameLocationAndTimeAgoView({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              userName,
              style:  GoogleFonts.notoSans(
                fontSize: TEXT_REGULAR_2X,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        const Text(
          "2 hours ago",
          style: TextStyle(
            fontSize: TEXT_SMALL,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
