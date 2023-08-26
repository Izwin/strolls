import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase{
  final AuthRepository authRepository;
  ForgetPasswordUseCase({required this.authRepository});

  Future<Either<Failure,void>> call(String email){
    return authRepository.forgetPassword(email);
  }
}