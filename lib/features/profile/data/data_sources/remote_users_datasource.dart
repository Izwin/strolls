import 'dart:io';

import 'package:dio/dio.dart';
import 'package:strolls/core/network/retrofit_client.dart';
import 'package:strolls/features/profile/data/models/update_profile_request_model.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';

import '../../../../core/error/my_server_exception.dart';

class RemoteUsersDatasource {
  final RetrofitClient retrofitClient;
  final Dio dio;

  RemoteUsersDatasource({required this.retrofitClient, required this.dio});

  Future<List<UserModel>> getUsers() {
    return retrofitClient.getUsers();
  }

  Future<UserModel> getProfile() async {
    var response = await dio.get("/profile");
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      var result = UserModel.fromJson(response.data);
      return result;
    } else {
      throw MyServerException(message: response.data["errorMessage"] ?? "");
    }
  }

  Future updateProfile(String bio, List<String> languages, String city) async {
    var updateProfileRequest =
        UpdateProfileRequestModel(city: city, bio: bio, languages: languages);
    var response =
        await dio.post("/profile/update", data: updateProfileRequest.toJson());
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: response.data["errorMessage"] ?? "");
    }
  }

  Future loadImageFile(File file) async {
    var response = await dio.post("/profile/update_image",
        data: FormData.fromMap({"image": await MultipartFile.fromFile(file.path)}));

    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: response.data["errorMessage"]);
    }
  }
}
