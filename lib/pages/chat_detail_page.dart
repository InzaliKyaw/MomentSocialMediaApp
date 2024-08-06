import 'dart:ffi';

import 'package:chatty/blocs/chat_detail_bloc.dart';
import 'package:chatty/data/vos/message_vo.dart';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../resources/dimens.dart';
import '../resources/images.dart';

class ChatDetailPage extends StatefulWidget {
  final String receiverProfilePic;
  final String receiverName;
  final String receiverId;

  const ChatDetailPage({super.key,required this.receiverId,required this.receiverName, required this.receiverProfilePic });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final FocusNode _focusNode = FocusNode();
  List<MessageVO>? chatList = [];
  String message = "";
  TextEditingController _messageController = TextEditingController();
  late ChatDetailBloc _chatDetailBloc;


  @override
  void initState() {
    super.initState();
    _chatDetailBloc = ChatDetailBloc();
    _chatDetailBloc.onReceiverIdChange(widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatDetailBloc(),
      child: Scaffold(
        body: Column(
          ///MainAxisAlignment Align children vertically
          ///CrossAxisAlignment Align children horizontally
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Container(
             decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.15),
                     spreadRadius: 0,
                     blurRadius: 20,
                     offset: const Offset(5, 5),
                   ),
                 ]
             ),
             child: Padding(
               padding: const EdgeInsets.only(top: MARGIN_WELCOME,bottom: MARGIN_CARD_MEDIUM_2),
               child: Row(
                 children: [
                   GestureDetector(
                       onTap: () {
                         Navigator.pop(context);
                       },
                       child: const Icon(Icons.chevron_left_outlined,
                       size: 32,)),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 14.0),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(CHAT_DETAIL_RADIUS),
                       child: Image.network(
                         widget.receiverProfilePic ?? "",
                         height: CHAT_IMG_DETAIL_H_W,
                         width: CHAT_IMG_DETAIL_H_W,
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                   Text(widget.receiverName ?? "",
                     style: const TextStyle(
                         fontSize: TEXT_REGULAR_3X,
                         color: primaryColor
                     ),),
                   Consumer<ChatDetailBloc>(
                     builder: (context, bloc, child)
                        {
                        bloc.onReceiverIdChange(widget.receiverId);
                        return  Visibility(
                          visible: false,
                          child: Text(widget.receiverId ?? "",
                              style: const TextStyle(
                                  fontSize: TEXT_REGULAR_3X,
                                  color: primaryColor
                              ),),
                        );
                       }
                         ,
                   ),
                 ],
               ),
             ),
           ),
           Flexible(
             child: Consumer<ChatDetailBloc>(
               builder: (context, bloc, child) {
                 var blocDetail = context.read<ChatDetailBloc>();
                 blocDetail.getChatMessages(widget.receiverId);
                 return  ListView.builder(
                     scrollDirection: Axis.vertical,
                     itemCount: bloc.getChatList?.length ?? 0,
                     itemBuilder: (context, index){
                       String? currId = bloc.currUserId;
                       MessageVO message = bloc.getChatList![index] ;
                       String? chatMessage = message.message;
                       int? timestamp = message.timestamp;
                       return Row(
                         ///MainAxisAlignment Align children horizontally
                         ///CrossAxisAlignment Align children vertically
                           mainAxisAlignment: (message.id == currId )? MainAxisAlignment.end : MainAxisAlignment.start,
                           children: [
                             Card(
                               color: (message.id == currId ) ? primaryColor: Colors.white,
                               child: Padding(
                                 padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
                                 child: Column(
                                   children: [
                                     Text( chatMessage?? "",
                                       style: TextStyle(
                                           fontSize: TEXT_REGULAR_3X,
                                           color: (message.id == currId ) ? Colors.white: Colors.black
                                       ),),
                                   ],
                                 ),
                               ),
                             )
                           ]
                       );
               });


               }),
             ),
           /// Keyboard
           Container(
             height: 100,
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             decoration: BoxDecoration(
                color: Colors.white,
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.15),
                   spreadRadius: 0,
                   blurRadius: 20,
                   offset: const Offset(4, 0),
                 ),
               ]
             ),
             child:  Padding(
               padding: const EdgeInsets.all(14.0),
               child: Consumer<ChatDetailBloc>(
                 builder: (context, bloc, child) =>
                  TextField(
                    controller: _messageController,
                    onChanged: (text){
                      setState(() {
                        message = text;
                      });
                    },
                   decoration: InputDecoration(
                     suffixIcon: Padding(
                       padding: const EdgeInsets.all(4.0),
                       child: GestureDetector(
                           onTap: (){
                             /// Message is added to both side
                             /// Add message to current user node
                              int timeStamp = DateTime.now().millisecondsSinceEpoch;
                              MessageVO messageVO = MessageVO(id: bloc.currUserVO?.id, image: "",message: message,profilePicture:"" ,timestamp: timeStamp,
                                  userName: bloc.currUserVO?.userName ?? ""
                              );
                              bloc.addNewMessage(bloc.currUserId, widget.receiverId, messageVO);

                              /* Add message to other user node
                               @FirstParam: Root Node
                               @SecondParam: Sub Rood Node
                               @ThirdParam: MessageVO
                               */
                              bloc.addNewMessage(widget.receiverId, bloc.currUserId, messageVO);

                              _messageController.clear();
                           },
                           child: Image.asset(CHAT_SEND, height:MARGIN_MEDIUM_2, width: MARGIN_MEDIUM_2,)),
                     ),
                     hintText: LBL_MESSAGE,
                     border: const OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(30.0))
                     ),
                   ),
                 ),
               ),
             ),
           ),
         ],
                  ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
