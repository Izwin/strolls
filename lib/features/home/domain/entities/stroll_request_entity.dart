import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';

part 'stroll_request_entity.g.dart';

@JsonSerializable()
class StrollRequestEntity {
  final int id;
  final UserModel userModel;
  final DateTime date;

  StrollRequestEntity({
    required this.userModel,
    required this.id,
    required this.date,
  });

  Map<String,dynamic> toJson() => _$StrollRequestEntityToJson(this);

  factory StrollRequestEntity.fromJson(Map<String, dynamic> json) => _$StrollRequestEntityFromJson(json);
}
