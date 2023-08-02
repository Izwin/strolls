part of 'authenticator_bloc.dart';

@immutable
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

class AuthenticatorDialog extends AuthenticatorState {
  final String message;

  AuthenticatorDialog({required this.message});
}
