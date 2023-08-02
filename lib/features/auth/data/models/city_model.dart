import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/auth/domain/entities/city_entity.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends CityEntity{
  CityModel({required super.city});

  factory CityModel.fromJson(Map<String, dynamic> json) => _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);

}