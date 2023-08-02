import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';

class GetStrollsUseCase{
  final StrollsRepository strollsRepository;
  GetStrollsUseCase({required this.strollsRepository});

  Future<Either<Failure,List<StrollEntity>>> call(){
    return strollsRepository.getStrolls();
  }
}