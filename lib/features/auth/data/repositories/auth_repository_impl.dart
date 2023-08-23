import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/core/error/my_server_exception.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/features/auth/data/data_sources/remote_cities_datasource.dart';
import 'package:strolls/features/auth/domain/entities/city_entity.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

import '../models/send_registration_params_model.dart';

class AuthRepositoryImpl extends AuthRepository{
  final RemoteCitiesDatasource remoteCitiesDatasource;
  AuthRepositoryImpl({required this.remoteCitiesDatasource});

  @override
  Future<Either<Failure, List<CityEntity>>> getCities() async{
    try{
      var result = await remoteCitiesDatasource.getCities();
      return Right(result);
    }
    on Exception catch (e){
      return Left(Failure( message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(SendRegistrationParamsModel sendRegistrationParams) async {
    try{
      var result = await remoteCitiesDatasource.register(sendRegistrationParams);

      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", result["accessToken"]);
      await prefs.setString("refreshToken", result["refreshToken"]);
      return Right(0);
    }
    on MyServerException catch (e){
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getLanguages() async {
    try{
      var result = await remoteCitiesDatasource.getLanguages();
      return Right(result);
    }
    on Exception catch (e){
      return Left(Failure( message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> auth(String username, String pass) async {
    try{
      var result = await remoteCitiesDatasource.auth(username, pass);
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", result["accessToken"]);
      await prefs.setString("refreshToken", result["refreshToken"]);
      return Right(result);
    }
    on Exception catch (e){
      return Left(Failure( message: e.toString()));
    }
  }

}