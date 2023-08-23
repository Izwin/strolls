import 'package:dartz/dartz.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';

import '../../../../core/error/failure.dart';

class AcceptStrollRequestUseCase{
  final StrollsRepository strollsRepository;
  AcceptStrollRequestUseCase({required this.strollsRepository});

  Future<Either<Failure,void>> call(int strollId,int userId){
    return strollsRepository.acceptStrollRequest(strollId, userId);
  }
}