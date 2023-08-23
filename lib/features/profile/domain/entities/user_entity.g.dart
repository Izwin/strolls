// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as int,
      avatarUrl: json['avatarUrl'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      city: json['city'] as String,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      username: json['username'] as String,
      bio: json['bio'] as String,
      friends: (json['friends'] as List<dynamic>)
          .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'avatarUrl': instance.avatarUrl,
      'username': instance.username,
      'age': instance.age,
      'languages': instance.languages,
      'friends': instance.friends,
      'city': instance.city,
      'gender': instance.gender,
      'bio': instance.bio,
      'lastname': instance.lastname,
    };
