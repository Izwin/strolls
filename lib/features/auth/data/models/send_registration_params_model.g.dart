// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_registration_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendRegistrationParamsModel _$SendRegistrationParamsModelFromJson(
        Map<String, dynamic> json) =>
    SendRegistrationParamsModel(
      city: json['city'] as String,
      firstname: json['firstname'] as String,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      lastname: json['lastname'] as String,
      bio: json['bio'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      email: json['email'] as String,
      username: json['username'] as String,
      gender: json['gender'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SendRegistrationParamsModelToJson(
        SendRegistrationParamsModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'bio': instance.bio,
      'languages': instance.languages,
      'city': instance.city,
    };
