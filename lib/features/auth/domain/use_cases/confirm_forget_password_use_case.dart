import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';

class ConfirmForgetPasswordUseCase{
  final AuthRepository authRepository;
  ConfirmForgetPasswordUseCase({required this.authRepository});

  Future<Either<Failure,void>> call(String email,String token){
    return authRepository.confirmForgetPassword(email,token);
  }
}