import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/home/data/models/stroll_model.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.avatarUrl,
      required super.firstname,
      required super.lastname,
      required super.age,
      required super.gender,
      required super.city,
      required super.languages,
      required super.username,
      required super.bio,
      required List<UserModel> super.friends});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
