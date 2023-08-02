import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/auth/domain/entities/city_entity.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';

class GetLanguagesUseCase{
  final AuthRepository citiesRepository;
  GetLanguagesUseCase({required this.citiesRepository});

  Future<Either<Failure,List<String>>> call(){
    return citiesRepository.getLanguages();
  }
}