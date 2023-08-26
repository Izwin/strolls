import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_use_case.dart';

import '../../features/auth/data/models/send_registration_params_model.dart';
import '../../features/auth/domain/use_cases/confirm_forget_password_use_case.dart';
import '../../features/auth/domain/use_cases/forget_password_use_case.dart';
import '../../features/auth/domain/use_cases/get_cities_use_case.dart';
import '../../features/auth/domain/use_cases/send_register_use_case.dart';
import 'authenticator_event.dart';
import 'authenticator_event.dart';
import 'authenticator_state.dart';

class AuthenticatorBloc extends Bloc<AuthenticatorEvent, AuthenticatorState> {
  GetProfileUseCase getProfileUseCase;
  SendRegisterUseCase sendRegisterUseCase;
  AuthUseCase authUseCase;
  ForgetPasswordUseCase forgetPasswordUseCase;
  ConfirmForgetPasswordUseCase confirmForgetPasswordUseCase;

  AuthenticatorBloc(
      {required this.sendRegisterUseCase,
      required this.authUseCase,
      required this.getProfileUseCase,
      required this.confirmForgetPasswordUseCase,
      required this.forgetPasswordUseCase})
      : super(AuthenticatorInitial()) {
    on<AuthenticatorStartEvent>(_onAuthenticatorStartEvent);
    on<SendRegistrationEvent>(_onSendRegistrationEvent);
    on<GetProfileAuthenticatorEvent>(_onGetProfileEvent);
    on<SendAuthEvent>(_onSendAuthEvent);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
    on<ConfirmForgetPasswordEvent>(_onConfirmForgetPasswordEvent);
  }

  void _onAuthenticatorStartEvent(
      AuthenticatorStartEvent event, Emitter emitter) {
    emit(AuthenticatorInitial());
  }

  Future<void> _onSendRegistrationEvent(
      SendRegistrationEvent event, Emitter emitter) async {
    emit(AuthenticatorLoading());
    var result = await sendRegisterUseCase(event.params);
    result.fold((l) {
      emit(AuthenticatorError(errorMessage: l.message));
    }, (r) {
      emit(AuthenticatorDialog(message: "Success registration"));
      emit(AuthorizedState());
    });
  }

  Future<void> _onSendAuthEvent(SendAuthEvent event, Emitter emitter) async {
    emit(AuthenticatorLoading());
    var result = await authUseCase(event.username, event.password);
    result.fold((l) {
      emit(AuthenticatorError(errorMessage: l.message));
    }, (r) {
      emit(AuthenticatorDialog(message: "Success auth"));
      emit(AuthorizedState());
    });
  }

  Future<void> _onGetProfileEvent(
      GetProfileAuthenticatorEvent event, Emitter emitter) async {
    emit(AuthenticatorLoading());
    var result = await getProfileUseCase();
    result.fold((l) {
      print(l.message);

      emit(UnauthorizedState());
    }, (r) {
      print("NAVIGAT1E");
      Get.put(r);

      emit(AuthorizedState().copyWith(userEntity: r));
    });
  }

  Future<void> _onForgetPasswordEvent(
      ForgetPasswordEvent event, Emitter emitter) async {
    var result = await forgetPasswordUseCase(event.email);
    result.fold((l) {
      emit(ForgetPasswordError(errorMessage: l.message));
    }, (r) {
      emit(ForgetPasswordTokenSentState());
    });
  }

  Future<void> _onConfirmForgetPasswordEvent(
      ConfirmForgetPasswordEvent event, Emitter emitter) async {
    var result = await confirmForgetPasswordUseCase(event.email,event.token);
    result.fold((l) {
      emit(ForgetPasswordError(errorMessage: l.message));
    }, (r) {
      emit(SuccessConfirmForgetPasswordState());
    });
  }
}
