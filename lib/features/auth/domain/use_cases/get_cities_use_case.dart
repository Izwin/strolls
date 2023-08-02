import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/auth/domain/entities/city_entity.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';

class GetCitiesUseCase{
  final AuthRepository citiesRepository;
  GetCitiesUseCase({required this.citiesRepository});

  Future<Either<Failure,List<CityEntity>>> call(){
    return citiesRepository.getCities();
  }
}