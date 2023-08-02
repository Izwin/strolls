import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/upload_profile_image_use_case.dart';

import '../../../domain/use_cases/get_profile_strolls_use_case.dart';
import '../../../domain/use_cases/get_profile_use_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final GetProfileStrollsUseCase getProfileStrollsUseCase;


  ProfileBloc(
      {required this.getProfileUseCase,
      required this.getProfileStrollsUseCase,})
      : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
    on<GetProfileStrollsEvent>(_onGetProfileStrollEvent);
  }

  Future<void> _onGetProfileEvent(
      GetProfileEvent event, Emitter emitter) async {
    emit(ProfileLoadingState());
    var result = await getProfileUseCase();
    result.fold((l) {
      emit(ProfileErrorState(message: "Error"));
    }, (r) {
      emit(GotProfileState(userEntity: r));
    });
  }

  Future<void> _onGetProfileStrollEvent(
      GetProfileStrollsEvent event, Emitter emitter) async {
    emit(ProfileStrollsLoadingState());
    var result = await getProfileStrollsUseCase();
    result.fold((l) {
      emit(ProfileErrorState(message: "Error"));
    }, (r) {
      emit(GotProfileStrollsState(strolls: r));
    });
  }

}
