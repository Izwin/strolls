import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase{
  final AuthRepository authRepository;

  ChangePasswordUseCase({required this.authRepository});

  Future<Either<Failure,void>> call(String email,String token,String password){
    return authRepository.changePassword(email, token, password);
  }
}