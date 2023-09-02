part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});
}

class GotProfileState extends ProfileState {
  final UserEntity userEntity;

  GotProfileState({required this.userEntity});
}

class GotProfileStrollsState extends ProfileState {
  final List<StrollEntity> strolls;

  GotProfileStrollsState({required this.strolls});
}

class ProfileLoadingState extends ProfileState {}

class GotMyProfileDataState extends ProfileState {
  final UserEntity userEntity;
  final List<StrollEntity> strolls;

  GotMyProfileDataState({required this.userEntity, required this.strolls});
}

class GotProfileDataState extends ProfileState {
  final UserEntity userEntity;
  final List<StrollEntity> strolls;
  final List<FriendshipRequestEntity> myRequests;
  final List<FriendshipRequestEntity> sentRequests;

  GotProfileDataState(
      {required this.userEntity,
      required this.strolls,
      required this.myRequests,
      required this.sentRequests});
}

