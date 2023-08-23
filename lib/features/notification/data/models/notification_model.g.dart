// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      receiverId: json['receiverId'] as int,
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      read: json['read'] as bool,
      sender: UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      strollModel: json['strollModel'] as int?,
      notificationType: json['notificationType'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notificationType': instance.notificationType,
      'title': instance.title,
      'read': instance.read,
      'date': instance.date.toIso8601String(),
      'receiverId': instance.receiverId,
      'sender': instance.sender,
      'strollModel': instance.strollModel,
    };
