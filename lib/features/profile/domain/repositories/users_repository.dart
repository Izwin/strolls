import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/entities/friendship_request_entity.dart';

import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();

  Future<Either<Failure, UserEntity>> getProfile();

  Future<Either<Failure, UserEntity>> getProfileById(int id);

  Future<Either<Failure, void>> updateProfile(
      String city, List<String> languages, String bio);

  Future<Either<Failure, void>> updateProfileImage(File file);


  Future<Either<Failure,void>> sendFriendRequest(int id);

  Future<Either<Failure,List<FriendshipRequestEntity>>> getSentFriendshipRequests();

  Future<Either<Failure,List<FriendshipRequestEntity>>> getMyFriendshipRequests();

  Future<Either<Failure,void>> acceptFriendRequest(int userId);

  Future<Either<Failure,void>> cancelFriendRequest(int userId);

  Future<Either<Failure,void>> deleteFriend(int userId);

}
