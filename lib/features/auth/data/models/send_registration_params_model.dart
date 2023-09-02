import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_registration_params_model.g.dart';

@JsonSerializable()
class SendRegistrationParamsModel{
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String password;
  final String gender;
  final DateTime dateOfBirth;
  final String bio;
  final List<String> languages;
  final String city;
  final String token;

  SendRegistrationParamsModel({
    required this.city,
    required this.firstname,
    required this.languages,
    required this.lastname,
    required this.bio,
    required this.dateOfBirth,
    required this.email,
    required this.username,
    required this.gender,
    required this.password,
    required this.token
  });

  factory SendRegistrationParamsModel.fromJson(Map<String, dynamic> json) => _$SendRegistrationParamsModelFromJson(json);
  Map<String, dynamic> toJson() => _$SendRegistrationParamsModelToJson(this);
}