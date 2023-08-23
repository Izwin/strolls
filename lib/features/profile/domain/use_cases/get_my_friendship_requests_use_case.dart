import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

import '../entities/friendship_request_entity.dart';

class GetMyFriendshipRequestsUseCase{
  final UserRepository userRepository;
  GetMyFriendshipRequestsUseCase({required this.userRepository});

  Future<Either<Failure,List<FriendshipRequestEntity>>> call(){
    return userRepository.getMyFriendshipRequests();
  }
}