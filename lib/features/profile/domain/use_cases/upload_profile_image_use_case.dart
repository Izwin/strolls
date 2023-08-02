import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';

class UploadProfileImageUseCase{
  final UserRepository userRepository;
  UploadProfileImageUseCase({required this.userRepository});

  Future<Either<Failure,void>> call(XFile file){
    return userRepository.updateProfileImage(File(file.path));
  }
}