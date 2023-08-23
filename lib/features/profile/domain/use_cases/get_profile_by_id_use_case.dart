import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

class GetProfileByIdUseCase {
  final UserRepository userRepository;

  GetProfileByIdUseCase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call(int id) {
    var profile = userRepository.getProfileById(id);
    return profile;
  }
}
