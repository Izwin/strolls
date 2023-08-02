import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';

import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();

  Future<Either<Failure, UserEntity>> getProfile();

  Future<Either<Failure, void>> updateProfile(
      String city, List<String> languages, String bio);

  Future<Either<Failure, void>> updateProfileImage(File file);
}
