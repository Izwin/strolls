part of 'strolls_bloc.dart';

abstract class StrollsEvent {}

class GetStrollsEvent extends StrollsEvent {}

class GetStrollsByPageEvent extends StrollsEvent {
  final int page;
  final int size;

  GetStrollsByPageEvent({required this.size,required this.page});
}

class GetStrollsByIdEvent extends StrollsEvent {
  final int id;

  GetStrollsByIdEvent({required this.id});
}

class CreateStrollsEvent extends StrollsEvent {
  final CreateStrollParams createStrollParams;

  CreateStrollsEvent({required this.createStrollParams});
}
