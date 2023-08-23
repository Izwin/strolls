part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class GetProfileByIdEvent extends ProfileEvent{
  final int id;

  GetProfileByIdEvent({required this.id});
}

class GetProfileStrollsEvent extends ProfileEvent{}




