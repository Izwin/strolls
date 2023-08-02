part of 'strolls_bloc.dart';

abstract class StrollsState {}

class StrollsInitial extends StrollsState {}

class StrollsLoadingState extends StrollsState {}

class StrollsErrorState extends StrollsState {
  final String message;

  StrollsErrorState({required this.message});
}

class GotStrollsState extends StrollsState {
  final List<StrollEntity> strolls;

  GotStrollsState({required this.strolls});
}

class StrollCreatedState extends StrollsState{}
