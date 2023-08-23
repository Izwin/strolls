import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

class CancelFriendRequestUseCase{
  final UserRepository userRepository;
  CancelFriendRequestUseCase({required this.userRepository});

  Future<Either<Failure,void>> call(int userId){
    return userRepository.cancelFriendRequest(userId);
  }
}