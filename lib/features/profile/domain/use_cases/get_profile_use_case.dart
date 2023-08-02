import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

class GetProfileUseCase {
  final UserRepository userRepository;

  GetProfileUseCase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call() {
    var profile = userRepository.getProfile();
    return profile;
  }
}
