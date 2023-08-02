import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

class UpdateProfileUseCase{
  final UserRepository userRepository;

  UpdateProfileUseCase({required this.userRepository});

  Future<Either<Failure,void>> call(String city,String bio,List<String> languages){
    return userRepository.updateProfile(city, languages, bio);
  }
}