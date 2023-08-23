// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroll_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StrollRequestEntity _$StrollRequestEntityFromJson(Map<String, dynamic> json) =>
    StrollRequestEntity(
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$StrollRequestEntityToJson(
        StrollRequestEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userModel': instance.userModel,
      'date': instance.date.toIso8601String(),
    };
