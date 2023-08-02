import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

import '../entities/user_entity.dart';

class GetUsersUseCase{
  final UserRepository userRepository;
  GetUsersUseCase({required this.userRepository});

  Future<Either<Failure,List<UserEntity>>> call(){
    return userRepository.getUsers();
  }
}