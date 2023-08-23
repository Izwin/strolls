import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/core/error/my_server_exception.dart';
import 'package:strolls/features/profile/data/data_sources/remote_users_datasource.dart';
import 'package:strolls/features/profile/domain/entities/friendship_request_entity.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UserRepository {
  final RemoteUsersDatasource remoteUsersDataSource;

  UsersRepositoryImpl({required this.remoteUsersDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      return Right(await remoteUsersDataSource.getUsers());
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      return Right(await remoteUsersDataSource.getProfile());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(
      String city, List<String> languages, String bio) async {
    try {
      return Right(
          await remoteUsersDataSource.updateProfile(bio, languages, city));
    } on MyServerException catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfileImage(File file) async {
    try {
      return Right(await remoteUsersDataSource.loadImageFile(file));
    } on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getProfileById(int id) async {
    try {
      return Right(await remoteUsersDataSource.getProfileById(id));
    } catch (e) {
    return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptFriendRequest(int userId) async {
    try {
      return Right(await remoteUsersDataSource.acceptFriendRequest(userId));
    } catch (e) {
    return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest(int id) async {
    try {
      return Right(await remoteUsersDataSource.sendFriendRequest(id));
    } catch (e) {
    return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FriendshipRequestEntity>>> getMyFriendshipRequests() async {
    try {
      return Right(await remoteUsersDataSource.getMyFriendRequests());
    } catch (e) {
    return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FriendshipRequestEntity>>> getSentFriendshipRequests() async {
    try {
      return Right(await remoteUsersDataSource.getSentFriendRequests());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelFriendRequest(int userId) async {
    try {
      return Right(await remoteUsersDataSource.cancelFriendRequest(userId));
    } catch (e) {
    return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFriend(int userId) async {
    try {
      return Right(await remoteUsersDataSource.deleteFriend(userId));
    } catch (e) {
    return Left(Failure(message: e.toString()));
    }
  }
}
