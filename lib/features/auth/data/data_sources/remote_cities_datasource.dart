import 'package:dio/dio.dart';
import 'package:strolls/core/error/my_server_exception.dart';
import 'package:strolls/core/network/retrofit_client.dart';
import 'package:strolls/features/auth/data/models/city_model.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

import '../models/send_registration_params_model.dart';

class RemoteCitiesDatasource {
  RetrofitClient retrofitClient;
  Dio dio;

  RemoteCitiesDatasource({required this.retrofitClient, required this.dio});

  Future<List<CityModel>> getCities() async {
    var response = await dio.get("/auth/cities");
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return (response.data as List<dynamic>)
          .map((e) => CityModel.fromJson(e))
          .toList();
    } else {
      throw MyServerException(message: response.data["errorMessage"] ?? "");
    }
  }

  Future<List<String>> getLanguages() async {
    var response = await dio.get("/auth/languages");
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      var result = response.data as List<dynamic>;
      return result.map((e) => e as String).toList();
    } else {
      throw MyServerException(message: response.data["errorMessage"] ?? "");
    }
  }

  Future<dynamic> register(SendRegistrationParamsModel sendRegistrationParams) async {
    var response = await dio.post("/auth/register",data: sendRegistrationParams.toJson());
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return response.data;
    } else {
      throw MyServerException(message: response.data["errorMessage"] ?? "");
    }
    return retrofitClient.register(sendRegistrationParams);
  }
}
