import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_use_case.dart';

import '../../features/auth/data/models/send_registration_params_model.dart';
import '../../features/auth/domain/use_cases/get_cities_use_case.dart';
import '../../features/auth/domain/use_cases/send_register_use_case.dart';


part 'authenticator_event.dart';
part 'authenticator_state.dart';

class AuthenticatorBloc extends Bloc<AuthenticatorEvent, AuthenticatorState> {
  GetProfileUseCase getProfileUseCase;
  SendRegisterUseCase sendRegisterUseCase;
  AuthUseCase authUseCase;

  AuthenticatorBloc({required this.sendRegisterUseCase,required this.authUseCase,required this.getProfileUseCase}) : super(AuthenticatorInitial()) {
    on<AuthenticatorStartEvent>(_onAuthenticatorStartEvent);
    on<SendRegistrationEvent>(_onSendRegistrationEvent);
    on<GetProfileAuthenticatorEvent>(_onGetProfileEvent);
    on<SendAuthEvent>(_onSendAuthEvent);
  }

  void _onAuthenticatorStartEvent(AuthenticatorStartEvent event,Emitter emitter){
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

  Future<void> _onSendAuthEvent(
      SendAuthEvent event, Emitter emitter) async {
    emit(AuthenticatorLoading());
    var result = await authUseCase(event.username,event.password);
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
}
