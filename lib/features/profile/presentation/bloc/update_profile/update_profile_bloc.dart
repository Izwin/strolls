import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/update_profile_use_case.dart';
import '../../../domain/use_cases/upload_profile_image_use_case.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;

  UpdateProfileBloc(
      {required this.updateProfileUseCase,
      required this.uploadProfileImageUseCase})
      : super(UpdateProfileInitial()) {
    on<SendUpdateProfileEvent>(_onSendUpdateProfileEvent);
    on<UploadImageEvent>(_onUploadImageEvent);
  }

  Future<void> _onSendUpdateProfileEvent(
      SendUpdateProfileEvent updateProfileEvent, Emitter emitter) async {
    emit(UpdateProfileLoadingState());
    var result = await updateProfileUseCase.call(
        updateProfileEvent.city,
        updateProfileEvent.bio,
        updateProfileEvent.languages);
    result.fold((l) {
      emit(SendUpdateProfileErrorState(error: l.message));
    }, (r) {
      emit(ProfileUpdatedState());
    });
  }

  Future<void> _onUploadImageEvent(
      UploadImageEvent updateProfileEvent, Emitter emitter) async {
    emit(UpdateProfileLoadingState());
    if(updateProfileEvent.file!=null){
      var result = await uploadProfileImageUseCase.call(
          updateProfileEvent.file!);
      result.fold((l) {
        emit(UploadImageErrorState(error: "Upload image error"));
      }, (r) {
        emit(ImageUploadedState());
      });
    }
    else{
      emit(UploadImageErrorState(error: "Upload image error"));
    }


  }
}
