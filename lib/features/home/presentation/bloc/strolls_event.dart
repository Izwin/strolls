part of 'strolls_bloc.dart';

abstract class StrollsEvent {}

class GetStrollsEvent extends StrollsEvent {}

class CreateStrollsEvent extends StrollsEvent{
  final CreateStrollParams createStrollParams;

  CreateStrollsEvent({required this.createStrollParams});
}
