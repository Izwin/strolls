
import '../../features/profile/domain/entities/user_entity.dart';

abstract class AuthenticatorState {}

class AuthenticatorInitial extends AuthenticatorState {}


class AuthorizedState extends AuthenticatorState {
  UserEntity? userEntity;

  AuthorizedState copyWith({required UserEntity userEntity}) {
    return this..userEntity = userEntity;
  }
}

class UnauthorizedState extends AuthenticatorState {}

class AuthenticatorLoading extends AuthenticatorState {}

class AuthenticatorError extends AuthenticatorState {
  final String errorMessage;

  AuthenticatorError({required this.errorMessage});
}


class ForgetPasswordError extends AuthenticatorState {
  final String errorMessage;

  ForgetPasswordError({required this.errorMessage});
}

class AuthenticatorDialog extends AuthenticatorState {
  final String message;

  AuthenticatorDialog({required this.message});
}

class ForgetPasswordTokenSentState extends AuthenticatorState{}

class SuccessConfirmForgetPasswordState extends AuthenticatorState{}
