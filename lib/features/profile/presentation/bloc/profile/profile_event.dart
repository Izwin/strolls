part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class GetMyProfileData extends ProfileEvent {}

class GetProfileByIdEvent extends ProfileEvent{
  final int id;

  GetProfileByIdEvent({required this.id});
}

class GetProfileByIdDataEvent extends ProfileEvent{
  final int id;

  GetProfileByIdDataEvent({required this.id});
}

class GetProfileStrollsEvent extends ProfileEvent{}




