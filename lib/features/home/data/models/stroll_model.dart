import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';

part 'stroll_model.g.dart';

@JsonSerializable()
class StrollModel extends StrollEntity {
  StrollModel(
      {required super.id,
      required super.gender,
      required super.minimumAge,
      required super.title,
      required List<UserModel> super.members,
      required UserModel super.creator,
      required super.date,
      required super.city,
      required super.language,
      required super.description});

  factory StrollModel.fromJson(Map<String, dynamic> json) =>
      _$StrollModelFromJson(json);

  Map<String, dynamic> toJson() => _$StrollModelToJson(this);
}
