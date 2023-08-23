part of 'authenticator_bloc.dart';

@immutable
abstract class AuthenticatorEvent {}
class AuthenticatorStartEvent extends AuthenticatorEvent{}

class GetProfileAuthenticatorEvent extends AuthenticatorEvent{}

class SendRegistrationEvent extends AuthenticatorEvent{
  final SendRegistrationParamsModel params;

  SendRegistrationEvent({required this.params});
}

class SendAuthEvent extends AuthenticatorEvent{
  final String username;
  final String password;
  SendAuthEvent({required this.username,required this.password});
}