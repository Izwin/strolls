// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_stroll_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStrollRequestModel _$CreateStrollRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateStrollRequestModel(
      date: DateTime.parse(json['date'] as String),
      age: json['age'] as int,
      city: json['city'] as String,
      language: json['language'] as String,
      gender: json['gender'] as String,
      note: json['note'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$CreateStrollRequestModelToJson(
        CreateStrollRequestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'note': instance.note,
      'city': instance.city,
      'language': instance.language,
      'gender': instance.gender,
      'date': instance.date.toIso8601String(),
      'age': instance.age,
    };
