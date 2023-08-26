import '../../features/auth/data/models/send_registration_params_model.dart';

abstract class AuthenticatorEvent {}

class AuthenticatorStartEvent extends AuthenticatorEvent {}

class GetProfileAuthenticatorEvent extends AuthenticatorEvent {}

class SendRegistrationEvent extends AuthenticatorEvent {
  final SendRegistrationParamsModel params;

  SendRegistrationEvent({required this.params});
}

class SendAuthEvent extends AuthenticatorEvent {
  final String username;
  final String password;

  SendAuthEvent({required this.username, required this.password});
}

class ForgetPasswordEvent extends AuthenticatorEvent {
  final String email;

  ForgetPasswordEvent({required this.email});
}

class ConfirmForgetPasswordEvent extends AuthenticatorEvent {
  final String email;
  final String token;

  ConfirmForgetPasswordEvent({required this.email, required this.token});
}
