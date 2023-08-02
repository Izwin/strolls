part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UploadImageErrorState extends UpdateProfileState {
  final String error;

  UploadImageErrorState({required this.error});
}

class SendUpdateProfileErrorState extends UpdateProfileState {
  final String error;

  SendUpdateProfileErrorState({required this.error});
}

class ImageUploadedState extends UpdateProfileState {}

class ProfileUpdatedState extends UpdateProfileState {}
