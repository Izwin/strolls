// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroll_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StrollRequestModel _$StrollRequestModelFromJson(Map<String, dynamic> json) =>
    StrollRequestModel(
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$StrollRequestModelToJson(StrollRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userModel': instance.userModel,
      'date': instance.date.toIso8601String(),
    };
