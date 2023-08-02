import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:strolls/features/auth/data/models/city_model.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';

import '../../features/auth/data/models/send_registration_params_model.dart';
import '../../features/auth/domain/entities/city_entity.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/")
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @GET("api/v1/auth/cities")
  Future<List<CityModel>> getCities();

  @GET("api/v1/auth/languages")
  Future<List<String>> getLanguages();

  @POST("api/v1/auth/refresh")
  Future<List<CityModel>> refreshToken();

  @GET("api/v1/users")
  Future<List<UserModel>> getUsers();

  @GET("api/v1/profile")
  Future<UserModel> getProfile();

  @POST("api/v1/auth/register")
  Future<dynamic> register(@Body() SendRegistrationParamsModel sendRegistrationParams);
}
