import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/domain/use_cases/get_strolls_by_user_id_use_case.dart';
import 'package:strolls/features/profile/domain/entities/friendship_request_entity.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/domain/use_cases/get_my_friendship_requests_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_by_id_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_sent_friendship_requests_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:strolls/features/profile/presentation/bloc/friends/friends_bloc.dart';
import 'package:strolls/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';

import '../../../domain/use_cases/get_profile_strolls_use_case.dart';
import '../../../domain/use_cases/get_profile_use_case.dart';
import '../../../domain/use_cases/send_friend_request_use_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final GetProfileByIdUseCase getProfileByIdUseCase;
  final GetProfileStrollsUseCase getProfileStrollsUseCase;
  final GetStrollsByUserIdUseCase getStrollsByUserIdUseCase;
  final GetMyFriendshipRequestsUseCase getMyFriendshipRequestsUseCase;
  final GetSentFriendshipRequestsUseCase getSentFriendshipRequestsUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.getProfileByIdUseCase,
    required this.getStrollsByUserIdUseCase,
    required this.getMyFriendshipRequestsUseCase,
    required this.getSentFriendshipRequestsUseCase,
    required this.getProfileStrollsUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
    on<GetProfileByIdEvent>(_onGetProfileByIdEvent);
    on<GetProfileStrollsEvent>(_onGetProfileStrollEvent);
    on<GetMyProfileData>(_onGetMyProfileDate);
    on<GetProfileByIdDataEvent>(_onGetProfileByIdDataEvent);
  }

  Future<void> _onGetProfileEvent(
      GetProfileEvent event, Emitter emitter) async {
    emit(ProfileLoadingState());
    var result = await getProfileUseCase();
    result.fold((l) {
      emit(ProfileErrorState(message: "Error"));
    }, (r) {
      Get.put(r);
      emit(GotProfileState(userEntity: r));
    });
  }

  Future<void> _onGetProfileByIdEvent(
      GetProfileByIdEvent event, Emitter emitter) async {
    emit(ProfileLoadingState());
    var result = await getProfileByIdUseCase(event.id);
    result.fold((l) {
      emit(ProfileErrorState(message: "Error"));
    }, (r) {
      emit(GotProfileState(userEntity: r));
    });
  }

  Future<void> _onGetProfileByIdDataEvent(
      GetProfileByIdDataEvent event, Emitter emitter) async {
    emit(ProfileLoadingState());
    var profileResult = await getProfileByIdUseCase(event.id);
    var strollsResult = await getStrollsByUserIdUseCase(event.id);
    var myFriendshipRequestsResult = await getMyFriendshipRequestsUseCase();
    var sentFriendshipRequestsResult = await getSentFriendshipRequestsUseCase();
    if(profileResult.isRight() && strollsResult.isRight() && myFriendshipRequestsResult.isRight() && sentFriendshipRequestsResult.isRight()){
      var profile = profileResult.getOrElse(() => throw Exception("User error"));
      var strolls = strollsResult.getOrElse(() => []);
      var myFriendshipRequest = myFriendshipRequestsResult.getOrElse(() => []);
      var sentFriendshipRequest = sentFriendshipRequestsResult.getOrElse(() => []);
      emit(GotProfileDataState(userEntity: profile, strolls: strolls, myRequests: myFriendshipRequest, sentRequests: sentFriendshipRequest));
    }

  }

  Future<void> _onGetProfileStrollEvent(
      GetProfileStrollsEvent event, Emitter emitter) async {
    emit(ProfileLoadingState());
    var result = await getProfileStrollsUseCase();
    result.fold((l) {
      emit(ProfileErrorState(message: "Error"));
    }, (r) {
      emit(GotProfileStrollsState(strolls: r));
    });
  }

  Future<void> _onGetMyProfileDate(
      GetMyProfileData event, Emitter emitter) async {
    emit(ProfileLoadingState());
    var strolls = await getProfileStrollsUseCase();
    var user = await getProfileUseCase();
    user.fold((l) {

    }, (userRight) {
      strolls.fold((l) {

      }, (strollsRight) {
        emit(GotMyProfileDataState(userEntity: userRight, strolls: strollsRight));

      });
    });
  }


}
