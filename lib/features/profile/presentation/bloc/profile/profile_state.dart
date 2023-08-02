part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileErrorState extends ProfileState{
  final String message;
  ProfileErrorState({required this.message});
}

class GotProfileState extends ProfileState{
  final UserEntity userEntity;
  GotProfileState({required this.userEntity});
}

class GotProfileStrollsState extends ProfileState{
  final List<StrollEntity> strolls;
  GotProfileStrollsState({required this.strolls});
}

class ProfileLoadingState extends ProfileState{}

class ProfileStrollsLoadingState extends ProfileState{}
