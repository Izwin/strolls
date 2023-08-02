import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/auth/domain/entities/city_entity.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

import '../../data/models/send_registration_params_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, List<CityEntity>>> getCities();

  Future<Either<Failure, List<String>>> getLanguages();

  Future<Either<Failure, void>> register(SendRegistrationParamsModel sendRegistrationParams);
}
