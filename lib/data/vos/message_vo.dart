import 'package:json_annotation/json_annotation.dart';
part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO{

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "timestamp")
  int? timestamp;

  @JsonKey(name: "user_name")
  String? userName;

  MessageVO({
    this.id,
    this.image,
    this.message,
    this.profilePicture,
    this.timestamp,
    this.userName,
  });

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}