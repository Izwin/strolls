part of 'stroll_single_bloc.dart';

@immutable
abstract class StrollSingleEvent {}

class GetStrollByIdEvent extends StrollSingleEvent {
  final int id;

  GetStrollByIdEvent({required this.id});
}

class GetStrollRequestsEvent extends StrollSingleEvent {
  final int id;

  GetStrollRequestsEvent({required this.id});
}

class RequestStrollEvent extends StrollSingleEvent {
  final int id;

  RequestStrollEvent({required this.id});
}

class AcceptStrollRequestEvent extends StrollSingleEvent {
  final int strollId;
  final int userId;

  AcceptStrollRequestEvent({required this.strollId, required this.userId});
}

class DeclineStrollRequestEvent extends StrollSingleEvent {
  final int strollId;
  final int userId;

  DeclineStrollRequestEvent({required this.strollId, required this.userId});
}