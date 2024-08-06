// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      id: json['id'] as String?,
      image: json['image'] as String?,
      message: json['message'] as String?,
      profilePicture: json['profile_picture'] as String?,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'message': instance.message,
      'profile_picture': instance.profilePicture,
      'timestamp': instance.timestamp,
      'user_name': instance.userName,
    };
