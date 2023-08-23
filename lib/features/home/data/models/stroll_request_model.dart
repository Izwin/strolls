import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/home/domain/entities/stroll_request_entity.dart';

import '../../../profile/data/models/user_model.dart';
import '../../domain/entities/stroll_entity.dart';

part 'stroll_request_model.g.dart';

@JsonSerializable()
class StrollRequestModel extends StrollRequestEntity{
  StrollRequestModel({required super.userModel, required super.id, required super.date});


  factory StrollRequestModel.fromJson(Map<String,dynamic> json) => _$StrollRequestModelFromJson(json);

  @override
  Map<String,dynamic> toJson() => _$StrollRequestModelToJson(this);

}