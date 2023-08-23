import 'package:dartz/dartz.dart';

import 'package:strolls/core/error/failure.dart';
import 'package:strolls/core/error/my_server_exception.dart';
import 'package:strolls/features/home/data/data_sources/remote_strolls_datasource.dart';
import 'package:strolls/features/home/domain/entities/stroll_request_entity.dart';

import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/domain/use_cases/create_stroll_use_case.dart';

import '../../domain/params/create_strolls_params.dart';
import '../../domain/repositories/strolls_repository.dart';

class StrollsRepositoryImpl extends StrollsRepository {
  final RemoteStrollsDatasource remoteStrollsDatasource;

  StrollsRepositoryImpl({required this.remoteStrollsDatasource});

  @override
  Future<Either<Failure, void>> createStroll(
      {required CreateStrollParams createStrollParams}) async {
    try {
      await remoteStrollsDatasource.createStroll(
          createStrollParams: createStrollParams);

      return Right(0);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<StrollEntity>>> getStrolls() async {
    try {
      var result = await remoteStrollsDatasource.getStrolls();
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<StrollEntity>>> getMyStrolls() async {
    try {
      var result = await remoteStrollsDatasource.getProfileStrolls();
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, StrollEntity>> getStrollById(int id) async {
    try {
      var result = await remoteStrollsDatasource.getStrollById(id);
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<StrollEntity>>> getUserStrolls(int id) async {
    try {
      var result = await remoteStrollsDatasource.getStrollsByUserId(id);
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> requestToStroll(int id) async {
    try {
      var result = await remoteStrollsDatasource.requestStroll(id);
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<StrollRequestEntity>>> getStrollRequests(int strollId) async {
    try {
      var result = await remoteStrollsDatasource.getStrollRequestsById(strollId);
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> acceptStrollRequest(int strollId, int userId) async {
    try {
      var result = await remoteStrollsDatasource.acceptStrollRequest(strollId,userId);
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> declineStrollRequest(int strollId, int userId) async {
    try {
      var result = await remoteStrollsDatasource.declineStrollRequest(strollId,userId);
      return Right(result);
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
