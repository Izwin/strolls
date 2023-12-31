import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/auth/domain/entities/city_entity.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

import '../../data/models/send_registration_params_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, List<CityEntity>>> getCities();

  Future<Either<Failure, List<String>>> getLanguages();

  Future<Either<Failure, void>> register(SendRegistrationParamsModel sendRegistrationParams);

  Future<Either<Failure, void>> auth(String username,String pass,String fcmToken);

  Future<Either<Failure,void>> forgetPassword(String email);

  Future<Either<Failure,void>> confirmForgetPassword(String email,String token);

  Future<Either<Failure,void>> changePassword(String email,String token,String password);
}
