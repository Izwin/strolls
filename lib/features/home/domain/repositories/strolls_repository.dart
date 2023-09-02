import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/home/domain/entities/stroll_request_entity.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/domain/use_cases/create_stroll_use_case.dart';

import '../params/create_strolls_params.dart';

abstract class StrollsRepository {
  Future<Either<Failure, List<StrollEntity>>> getStrolls();

  Future<Either<Failure, List<StrollEntity>>> getStrollsByPage(int page,int size);

  Future<Either<Failure, void>> createStroll({
    required CreateStrollParams createStrollParams
  });

  Future<Either<Failure, List<StrollEntity>>> getMyStrolls();

  Future<Either<Failure, StrollEntity>> getStrollById(int id);

  Future<Either<Failure, List<StrollEntity>>> getUserStrolls(int id);

  Future<Either<Failure,void>> requestToStroll(int id);

  Future<Either<Failure,void>> acceptStrollRequest(int strollId,int userId);

  Future<Either<Failure,void>> declineStrollRequest(int strollId,int userId);

  Future<Either<Failure,List<StrollRequestEntity>>> getStrollRequests(int strollId);





}
