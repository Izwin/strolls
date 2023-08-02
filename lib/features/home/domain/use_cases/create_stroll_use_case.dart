import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';

import '../params/create_strolls_params.dart';

class CreateStrollUseCase {
  final StrollsRepository strollsRepository;

  CreateStrollUseCase({required this.strollsRepository});

  Future<Either<Failure, void>> call(CreateStrollParams createStrollParams) {
    return strollsRepository.createStroll(createStrollParams: createStrollParams);
  }
}


