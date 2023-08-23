import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/home/domain/use_cases/accept_stroll_request_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/decline_stroll_request_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/get_stroll_requests_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/request_stroll_use_case.dart';

import '../../../domain/entities/stroll_entity.dart';
import '../../../domain/entities/stroll_request_entity.dart';
import '../../../domain/use_cases/get_stroll_by_id_use_case.dart';

part 'stroll_single_event.dart';

part 'stroll_single_state.dart';

class StrollSingleBloc extends Bloc<StrollSingleEvent, StrollSingleState> {
  final GetStrollByIdUseCase getStrollByIdUseCase;
  final RequestStrollUseCase requestStrollUseCase;
  final GetStrollRequestsUseCase getStrollRequestsUseCase;
  final AcceptStrollRequestUseCase acceptStrollRequestUseCase;
  final DeclineStrollRequestUseCase declineStrollRequestUseCase;

  StrollSingleBloc(
      {required this.getStrollByIdUseCase,
      required this.getStrollRequestsUseCase,
      required this.declineStrollRequestUseCase,
      required this.acceptStrollRequestUseCase,
      required this.requestStrollUseCase})
      : super(StrollSingleInitial()) {
    on<GetStrollByIdEvent>(_onGetStrollByIdEvent);
    on<RequestStrollEvent>(_onRequestStrollEvent);
    on<GetStrollRequestsEvent>(_onGetStrollRequestsEvent);
    on<DeclineStrollRequestEvent>(_onDeclinedStrollRequestEvent);
    on<AcceptStrollRequestEvent>(_onAcceptStrollRequestEvent);
  }

  Future<void> _onGetStrollByIdEvent(
      GetStrollByIdEvent getStrollByIdEvent, Emitter emitter) async {
    emit(StrollSingleLoadingState());
    var result = await getStrollByIdUseCase(getStrollByIdEvent.id);
    result.fold((l) {
      emit(StrollSingleErrorState(error: l.message));
    }, (r) {
      emit(GotStrollSingleState(strollEntity: r));
    });
  }

  Future<void> _onRequestStrollEvent(
      RequestStrollEvent requestStrollEvent, Emitter emitter) async {
    emit(StrollSingleLoadingState());
    var result = await requestStrollUseCase(requestStrollEvent.id);
    result.fold((l) {
      emit(StrollSingleErrorState(error: l.message));
    }, (r) {
      emit(RequestedStrollState());
    });
  }

  Future<void> _onGetStrollRequestsEvent(
      GetStrollRequestsEvent requestStrollEvent, Emitter emitter) async {
    emit(StrollSingleLoadingState());
    var result = await getStrollRequestsUseCase(requestStrollEvent.id);
    result.fold((l) {
      emit(StrollSingleErrorState(error: l.message));
    }, (r) {
      emit(GotStrollsRequestsState(strollRequests: r));
    });
  }

  Future<void> _onAcceptStrollRequestEvent(
      AcceptStrollRequestEvent requestStrollEvent, Emitter emitter) async {
    emit(StrollSingleLoadingState());
    var result = await acceptStrollRequestUseCase.call(requestStrollEvent.strollId, requestStrollEvent.userId);
    result.fold((l) {
      emit(StrollSingleErrorState(error: l.message));
    }, (r) {
      emit(RequestAcceptedState());
    });
  }

  Future<void> _onDeclinedStrollRequestEvent(
      DeclineStrollRequestEvent requestStrollEvent, Emitter emitter) async {
    emit(StrollSingleLoadingState());
    var result = await declineStrollRequestUseCase.call(requestStrollEvent.strollId, requestStrollEvent.userId);
    result.fold((l) {
      emit(StrollSingleErrorState(error: l.message));
    }, (r) {
      emit(RequestDeclinedState());
    });
  }



}
