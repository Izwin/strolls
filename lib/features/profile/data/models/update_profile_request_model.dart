import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request_model.g.dart';

@JsonSerializable()
class UpdateProfileRequestModel {
  final String city;
  final List<String> languages;
  final String bio;

  UpdateProfileRequestModel(
      {required this.city, required this.bio, required this.languages});

  factory UpdateProfileRequestModel.fromJson(Map<String,dynamic> json) => _$UpdateProfileRequestModelFromJson(json);

  Map<String,dynamic> toJson() => _$UpdateProfileRequestModelToJson(this);
}
