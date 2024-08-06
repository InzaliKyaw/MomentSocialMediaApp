import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "birthday")
  String? birthday;

  @JsonKey(name: "gender")
  String? gender;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  UserVO({
    this.id,
    this.userName,
    this.phone,
    this.password,
    this.email,
    this.birthday,
    this.gender,
    this.profilePicture
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
