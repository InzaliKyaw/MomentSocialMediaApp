import 'package:chatty/blocs/contact_bloc.dart';
import 'package:chatty/data/vos/user_vo.dart';
import 'package:chatty/pages/qr_code_reader.dart';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/images.dart';
import 'package:chatty/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/dimens.dart';


class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ContactBloc(),
      child: Scaffold(
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100.0,
                floating: false,
                pinned: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace:  FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      children: [
                        const Text(LBL_CONTACT,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontFamily: 'YorkieDEMO',
                          ),),
                        const Spacer(),
                        GestureDetector(
                          onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)
                          => const QrCodeReader()));
                          },
                          child: Image.asset(
                            CONTACT_ADD,
                            width: 26,
                            height: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Selector<ContactBloc, List<UserVO>>
                (selector: (context, bloc) => bloc.getAllContactList,
                builder:(context, contactList, model){
                  return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          UserVO contact = contactList[index];
                          String profilePic = contact.profilePicture ?? "";
                          return Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0,left: 4.0, right: 4.0 ),
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Card(
                                    elevation: 4.0,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:  const EdgeInsets.symmetric(horizontal: 14.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(CHAT_RADIUS),
                                              child: Image.network(
                                                profilePic.isEmpty ? NETWORK_IMAGE_POST_PLACEHOLDER : profilePic ,
                                                height: CHAT_IMG_H_W,
                                                width: CHAT_IMG_H_W,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text(contact.userName ?? "",
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
                        );
                },childCount: contactList.length
                  ),

                  );
                }
              ),
            ]

        ),
      ),
    );
  }
}
