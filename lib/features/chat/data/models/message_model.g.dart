// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      userId: json['userId'] as int,
      username: json['username'] as String,
      userAvatar: json['userAvatar'] as String?,
      id: json['id'] as int,
      message: json['message'] as String,
      type: json['type'] as String,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userAvatar': instance.userAvatar,
      'username': instance.username,
      'dateTime': instance.dateTime?.toIso8601String(),
      'type': instance.type,
      'message': instance.message,
    };
