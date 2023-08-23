part of 'stroll_single_bloc.dart';

@immutable
abstract class StrollSingleState {}

class StrollSingleInitial extends StrollSingleState {}

class StrollSingleLoadingState extends StrollSingleState {}

class StrollSingleErrorState extends StrollSingleState {
  final String error;

  StrollSingleErrorState({required this.error});
}

class GotStrollSingleState extends StrollSingleState {
  final StrollEntity strollEntity;

  GotStrollSingleState({required this.strollEntity});
}

class GotStrollsRequestsState extends StrollSingleState {
  final List<StrollRequestEntity> strollRequests;

  GotStrollsRequestsState({required this.strollRequests});
}

class RequestedStrollState extends StrollSingleState {}

class RequestAcceptedState extends StrollSingleState {}

class RequestDeclinedState extends StrollSingleState {}
