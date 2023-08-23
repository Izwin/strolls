import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';

class RequestStrollUseCase{
  final StrollsRepository strollsRepository;
  RequestStrollUseCase({required this.strollsRepository});

  Future<Either<Failure,void>> call(int id){
    return strollsRepository.requestToStroll(id);
  }
}