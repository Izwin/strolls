import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/auth/domain/use_cases/get_languages_use_case.dart';
import 'package:strolls/features/auth/domain/use_cases/send_register_use_case.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_state.dart';

import '../../domain/use_cases/get_cities_use_case.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  GetCitiesUseCase getCitiesUseCase;
  GetLanguagesUseCase getLanguagesUseCase;

  RegistrationBloc(
      {required this.getCitiesUseCase,required this.getLanguagesUseCase})
      : super(RegistrationInitial()) {
    on<GetCitiesEvent>(_onGetCitiesEvent);
    on<GetLanguagesEvent>(_onGetLanguagesEvent);
  }

  Future<void> _onGetCitiesEvent(GetCitiesEvent event, Emitter emitter) async {
    emit(RegistrationLoading());
    var result = await getCitiesUseCase();
    result.fold((l) {
      emit(RegistrationError(errorMessage: l.message));
    }, (r) {
      emit(GotCitiesState(cities: r.map((e) => e.city).toList()));
    });
  }

  Future<void> _onGetLanguagesEvent(GetLanguagesEvent event, Emitter emitter) async {
    emit(RegistrationLoading());
    var result = await getLanguagesUseCase();
    result.fold((l) {
      emit(RegistrationError(errorMessage: l.message));
    }, (r) {
      emit(GotLanguagesState(languages: r));
    });
  }

}
