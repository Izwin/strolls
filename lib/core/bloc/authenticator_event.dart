part of 'authenticator_bloc.dart';

@immutable
abstract class AuthenticatorEvent {}
class AuthenticatorStartEvent extends AuthenticatorEvent{}

class GetProfileEvent extends AuthenticatorEvent{}

class SendRegistrationEvent extends AuthenticatorEvent{
  final SendRegistrationParamsModel params;

  SendRegistrationEvent({required this.params});
}
