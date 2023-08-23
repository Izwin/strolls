import 'package:dartz/dartz.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

import '../../../../core/error/failure.dart';

class AcceptFriendRequestUseCase{
  final UserRepository userRepository;

  AcceptFriendRequestUseCase({required this.userRepository});

  Future<Either<Failure,void>> call(int userId){
    return userRepository.acceptFriendRequest(userId);
  }
}