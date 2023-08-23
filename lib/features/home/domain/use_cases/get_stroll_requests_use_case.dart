import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/home/domain/entities/stroll_request_entity.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';

class GetStrollRequestsUseCase{
  final StrollsRepository strollsRepository;
  GetStrollRequestsUseCase({required this.strollsRepository});

  Future<Either<Failure,List<StrollRequestEntity>>> call(int strollId){
    return strollsRepository.getStrollRequests(strollId);
  }
}
