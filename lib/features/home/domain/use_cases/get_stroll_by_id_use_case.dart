import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';

class GetStrollByIdUseCase{
  final StrollsRepository strollsRepository;
  GetStrollByIdUseCase({required this.strollsRepository});

  Future<Either<Failure,StrollEntity>> call(int id){
    return strollsRepository.getStrollById(id);
  }
}