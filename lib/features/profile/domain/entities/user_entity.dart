import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final int id;
  final String firstname;
  final String avatarUrl;
  final String username;
  final int age;
  final List<String> languages;
  final List<UserEntity>? friends;
  final String city;
  final String gender;
  final String bio;
  final String lastname;

  UserEntity({
    required this.id,
    required this.avatarUrl,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.gender,
    required this.city,
    required this.languages,
    required this.username,
    required this.bio,
    required this.friends,
  });

    factory UserEntity.fromJson(Map<String,dynamic> json) => _$UserEntityFromJson(json);

    Map<String,dynamic> toJson() => _$UserEntityToJson(this);
}
