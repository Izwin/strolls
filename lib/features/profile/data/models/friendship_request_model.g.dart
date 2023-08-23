// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendshipRequestModel _$FriendshipRequestModelFromJson(
        Map<String, dynamic> json) =>
    FriendshipRequestModel(
      dateTime: DateTime.parse(json['dateTime'] as String),
      senderId: json['senderId'] as int,
      receiverId: json['receiverId'] as int,
    );

Map<String, dynamic> _$FriendshipRequestModelToJson(
        FriendshipRequestModel instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
    };
