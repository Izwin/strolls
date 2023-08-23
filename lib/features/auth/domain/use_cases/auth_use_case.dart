import 'package:dartz/dartz.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/send_registration_params_model.dart';
import '../../presentation/bloc/registration_event.dart';

class AuthUseCase{
  final AuthRepository authRepository;
  AuthUseCase({required this.authRepository});

  Future<Either<Failure,void>> call(String username,String pass){
    return authRepository.auth(username, pass);
  }
}