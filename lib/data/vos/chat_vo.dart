// import 'package:json_annotation/json_annotation.dart';
// import 'message_vo.dart';
//
// @JsonSerializable()
// class ChatVO{
//
//   // Map<String, List<MessageVO>> messages;
//   List<MessageVO>? messages;
//
//   ChatVO({ this.messages});
//
//   // factory ChatVO.fromJson(Map<String, dynamic> json) {
//   //   Map<String, List<MessageVO>> messages = {};
//   //   json.forEach((key, value) {
//   //     List<MessageVO> chatMessages = [];
//   //     value.forEach((v) {
//   //       chatMessages.add(MessageVO.fromJson(v));
//   //     });
//   //     messages[key] = chatMessages;
//   //   });
//   //   return ChatVO(messages: messages);
//   // }
//   //
//   // Map<String, dynamic> toJson() {
//   //   Map<String, dynamic> data = {};
//   //   messages.forEach((key, value) {
//   //     data[key] = value.map((v) => v.toJson()).toList();
//   //   });
//   //   return data;
//   // }
//
//   factory ChatVO.fromJson(Map<String, dynamic> json) =>
//       _$ChatVOFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ChatVOToJson(this);
// }