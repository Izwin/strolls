part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class ProfileUpdateError extends UpdateProfileState {
  final String error;

  ProfileUpdateError({required this.error});
}

class ImageUploadedState extends UpdateProfileState {}

class ProfileUpdatedState extends UpdateProfileState {}
