import 'package:chatty/blocs/chat_bloc.dart';
import 'package:chatty/pages/chat_detail_page.dart';
import 'package:chatty/resources/dimens.dart';
import 'package:chatty/resources/images.dart';
import 'package:chatty/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/vos/user_vo.dart';
import '../resources/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100.0,
                floating: false,
                pinned: false,
                shadowColor: Colors.grey,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace:  FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      children: [
                        const Text(LBL_CHAT,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontFamily: 'YorkieDEMO',
                          ),),
                        const Spacer(),
                        Image.asset(
                          SEARCH_BUTTON,
                          width: 26,
                          height: 26,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Consumer<ChatBloc>(
                builder: (context,bloc, child)
                  => SliverToBoxAdapter(
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bloc.getAllContactList.length,
                          itemBuilder: (context, index) {
                            UserVO? user = bloc.getAllContactList[index];
                            String profilePic = "";
                            String receiverId = "";
                            String receiverName = "";
                            if (user != null) {
                              profilePic = user.profilePicture ?? "";
                              receiverId = user.id ?? "";
                              receiverName = user.userName ?? "";
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => ChatDetailPage(receiverId:
                                    receiverId , receiverName: receiverName, receiverProfilePic: profilePic))
                                  );
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.transparent,
                                            child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: ClipOval(
                                                  child: Image.network( profilePic.isEmpty ? NETWORK_IMAGE_POST_PLACEHOLDER : profilePic,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                            )
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.greenAccent,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 4.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } ),
                    ),
                  )
              ),
              Consumer<ChatBloc>(
                  builder: (context,bloc, child){
                    List<UserVO> chattedContactList = [];
                    if(bloc.getChattedContactIdList.isNotEmpty && bloc.getAllContactList.isNotEmpty ){
                      for(var contact in bloc.getAllContactList){
                        for (var id in bloc.getChattedContactIdList){
                          if( contact.id == id){
                            chattedContactList.add(contact);
                          }
                        }
                      }
                    }
                  return SliverFillRemaining(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: chattedContactList.length,
                        itemBuilder: (context, index) {
                          UserVO? chattedUsers;
                          if(chattedContactList.isNotEmpty){
                            chattedUsers = chattedContactList[index];
                          }
                          bloc.onChattedContactList(chattedContactList);
                          return (chattedContactList.isNotEmpty ) ?
                          Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatDetailPage(
                                    receiverId: chattedUsers!.id.toString() ,receiverProfilePic: chattedUsers.profilePicture ?? "", receiverName: chattedUsers.userName ?? "",)));
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                       elevation: 3.0,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(CHAT_RADIUS),
                                                child: Image.network(
                                                  chattedUsers?.profilePicture ?? "",
                                                  height: CHAT_IMG_H_W,
                                                  width: CHAT_IMG_H_W,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text(chattedUsers?.userName ?? "",
                                                style: const TextStyle(
                                                    fontSize: TEXT_REGULAR_3X,
                                                    color: primaryColor
                                                ),),
                                            ),
                                            const Spacer(),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text("3/08/2024",
                                                style: TextStyle(
                                                    fontSize: TEXT_SMALL,
                                                    color: Colors.black
                                                ),),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              )
                          ) :
                          Container();
                        } ),
                  );
                  }
              ),

            ]

        ),
      ),
    );
  }
}
