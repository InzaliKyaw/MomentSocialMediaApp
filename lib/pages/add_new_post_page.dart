import 'dart:io';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/widgets/small_primary_button_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../blocs/add_new_post_bloc.dart';
import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/vos/user_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/loading_view.dart';
import '../widgets/primary_button_view.dart';
import '../widgets/profile_image_view.dart';

class AddNewPostPage extends StatefulWidget {
  final int? newsFeedId;


  const AddNewPostPage({
    Key? key,
    this.newsFeedId,
  }) : super(key: key);

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewPostBloc(newsFeedId: widget.newsFeedId),
      child: Selector<AddNewPostBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: false,
                title: Container(
                  margin: const EdgeInsets.only(
                    left: MARGIN_MEDIUM,
                  ),
                  child: Row(
                    children:[
                      const Text(
                        LBL_NEW_MOMENT,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: TEXT_HEADING_1X,
                          color: primaryColor,
                          fontFamily: 'YorkieDEMO',
                        ),
                      ),
                      const Spacer(),
                      Consumer<AddNewPostBloc>(
                        builder: (context, bloc, child) => SmallPrimaryButtonView(label: LBL_CREATE, onTap: (){
                          // bloc.getCurrentUser(bloc.currUserId ?? "");
                          String? profile =  bloc.currUserVO?.profilePicture ?? "";
                          bloc.onTapAddNewPost(profile).then((value) {
                            Navigator.pop(context);
                          });
                        },),
                      )
                    ]
                  ),
                ),
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: MARGIN_XLARGE,
                  ),
                ),
              ),
              body: Container(
                margin: const EdgeInsets.only(
                  top: MARGIN_XLARGE,
                ),
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileImageAndNameView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      AddNewPostTextFieldView(),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      PostDescriptionErrorView(),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      PostImageView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      SizedBox(
                        height: MARGIN_XLARGE,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: LoadingView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostImageView extends StatefulWidget {
  const PostImageView({Key? key}) : super(key: key);

  @override
  State<PostImageView> createState() => _PostImageViewState();
}

class _PostImageViewState extends State<PostImageView> {
  @override
  Widget build(BuildContext context) {
    List<File> imageList = [];

    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 140,
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: GestureDetector(
                child: Image.network(
                  "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640",
                ),
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  // Pick an image
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery);
                  if (image != null) {
                    imageList.add(File(image.path));
                    bloc.onImageChosen(imageList);
                  }
                },
              ),
            ),
            Row(
              children: imageList.asMap().entries.map((entry) {
                int index = entry.key;
                File imgFile = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          imgFile,
                          fit: BoxFit.cover,
                          height: 140,
                          width: 120,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            imageList.removeAt(index);
                            bloc.onTapDeleteImage(imgFile);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PostDescriptionErrorView extends StatelessWidget {
  const PostDescriptionErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => Visibility(
        visible: bloc.isAddNewPostError,
        child: const Text(
          "Post should not be empty",
          style: TextStyle(
            color: Colors.red,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class PostButtonView extends StatelessWidget {
  const PostButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => GestureDetector(
        onTap: () {

          bloc.onTapAddNewPost(bloc.currUserProfile ?? "").then((value) {
            Navigator.pop(context);
          });
        },
        child: PrimaryButtonView(
          label: LBL_POST,
          themeColor: bloc.themeColor, onTap: (){
          bloc.onTapAddNewPost(bloc.currUserProfile ?? "").then((value) {
            Navigator.pop(context);
          });
        },
        ),
      ),
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  const ProfileImageAndNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          ProfileImageView(
            profileImage:  bloc.currUserVO?.profilePicture ?? "",
          ),
          const SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          Text(
            bloc.userName ?? "",
            style: const TextStyle(
              fontSize: TEXT_REGULAR_2X,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AddNewPostTextFieldView extends StatelessWidget {
  const AddNewPostTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => SizedBox(
        height: ADD_NEW_POST_TEXTFIELD_HEIGHT,
        child: TextField(
          maxLines: 24,
          controller: TextEditingController(text: bloc.newPostDescription),
          onChanged: (text) {
            bloc.onNewPostTextChanged(text);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                MARGIN_MEDIUM,
              ),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            hintText: "What's on your mind?",
          ),
        ),
      ),
    );
  }
}
