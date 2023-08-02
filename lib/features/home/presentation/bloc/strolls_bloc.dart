import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/home/domain/use_cases/create_stroll_use_case.dart';

import '../../domain/entities/stroll_entity.dart';
import '../../domain/params/create_strolls_params.dart';
import '../../domain/use_cases/get_strolls_use_case.dart';

part 'strolls_event.dart';

part 'strolls_state.dart';

class StrollsBloc extends Bloc<StrollsEvent, StrollsState> {
  final GetStrollsUseCase getStrollsUseCase;
  final CreateStrollUseCase createStrollUseCase;

  StrollsBloc(
      {required this.createStrollUseCase, required this.getStrollsUseCase})
      : super(StrollsInitial()) {
    on<GetStrollsEvent>(_onGetStrollsEvent);
    on<CreateStrollsEvent>(_onCreateStrollsEvent);
  }

  Future<void> _onCreateStrollsEvent(
      CreateStrollsEvent createStrollsEvent, Emitter emitter) async {
    emit(StrollsLoadingState());
    var result =
        await createStrollUseCase(createStrollsEvent.createStrollParams);
    result.fold((l) {
      emit(StrollsErrorState(message: l.message));
    }, (r) {
      emit(StrollCreatedState());
    });
  }

  Future<void> _onGetStrollsEvent(
      GetStrollsEvent getStrollsEvent, Emitter emitter) async {
    emit(StrollsLoadingState());
    var result = await getStrollsUseCase();
    result.fold((l) {
      emit(StrollsErrorState(message: l.message));
    }, (r) {
      emit(GotStrollsState(strolls: r));
    });
  }
}
