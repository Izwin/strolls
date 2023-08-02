part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent {}

class SendUpdateProfileEvent extends UpdateProfileEvent {
  final String bio;
  final String city;
  final List<String> languages;

  SendUpdateProfileEvent(
      {required this.languages, required this.bio, required this.city});
}

class UploadImageEvent extends UpdateProfileEvent {
  final XFile? file;

  UploadImageEvent({
    required this.file});
}
