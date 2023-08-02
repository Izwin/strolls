// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroll_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StrollEntity _$StrollEntityFromJson(Map<String, dynamic> json) => StrollEntity(
      id: json['id'] as int,
      gender: json['gender'] as String,
      minimumAge: json['minimumAge'] as int,
      title: json['title'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      creator: UserEntity.fromJson(json['creator'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      city: json['city'] as String,
      language: json['language'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$StrollEntityToJson(StrollEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'gender': instance.gender,
      'minimumAge': instance.minimumAge,
      'members': instance.members,
      'creator': instance.creator,
      'language': instance.language,
      'city': instance.city,
    };
