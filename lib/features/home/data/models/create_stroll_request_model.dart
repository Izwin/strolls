import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_stroll_request_model.g.dart';

@JsonSerializable()
class CreateStrollRequestModel {
  String title;
  String note;
  String city;
  String language;
  String gender;
  DateTime date;
  int age;

  CreateStrollRequestModel({
    required this.date,
    required this.age,
    required this.city,
    required this.language,
    required this.gender,
    required this.note,
    required this.title,
  });

  Map<String, dynamic> toJson() => _$CreateStrollRequestModelToJson(this);

  factory CreateStrollRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateStrollRequestModelFromJson(json);
}
