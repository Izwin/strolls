import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';

import '../../../profile/domain/entities/user_entity.dart';

part 'stroll_entity.g.dart';

@JsonSerializable()
class StrollEntity {
  int id;
  String title;
  String description;
  DateTime date;
  String gender;
  int minimumAge;
  List<UserEntity> members;
  UserEntity creator;
  String language;
  String city;

  StrollEntity({
    required this.id,
    required this.gender,
    required this.minimumAge,
    required this.title,
    required this.members,
    required this.creator,
    required this.date,
    required this.city,
    required this.language,
    required this.description,
  });

  factory StrollEntity.fromJson(Map<String,dynamic> json) => _$StrollEntityFromJson(json);

  Map<String,dynamic> toJson() => _$StrollEntityToJson(this);

}
