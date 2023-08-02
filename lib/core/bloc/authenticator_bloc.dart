import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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

  AuthenticatorBloc({required this.sendRegisterUseCase,required this.getProfileUseCase}) : super(AuthenticatorInitial()) {
    on<AuthenticatorStartEvent>(_onAuthenticatorStartEvent);
    on<SendRegistrationEvent>(_onSendRegistrationEvent);
    on<GetProfileEvent>(_onGetProfileEvent);
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

  Future<void> _onGetProfileEvent(
      GetProfileEvent event, Emitter emitter) async {
    emit(AuthenticatorLoading());
    var result = await getProfileUseCase();
    result.fold((l) {
      print(l.message);

      emit(UnauthorizedState());
    }, (r) {
      print("NAVIGAT1E");

      emit(AuthorizedState());
    });
  }
}
