import 'package:dio/dio.dart';
import 'package:strolls/core/error/my_server_exception.dart';
import 'package:strolls/features/home/data/models/create_stroll_request_model.dart';
import 'package:strolls/features/home/data/models/stroll_request_model.dart';
import 'package:strolls/features/home/data/models/stroll_model.dart';
import 'package:strolls/features/home/domain/use_cases/create_stroll_use_case.dart';

import '../../domain/params/create_strolls_params.dart';

class RemoteStrollsDatasource {
  final Dio dio;

  RemoteStrollsDatasource({required this.dio});

  Future<List<StrollModel>> getStrolls() async {
    var result = await dio.get("/strolls/get");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      var strolls =
          (result.data as List).map((e) => StrollModel.fromJson(e)).toList();
      return strolls;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<void> createStroll({
    required CreateStrollParams createStrollParams,
  }) async {
    var requestModel = CreateStrollRequestModel(
        date: createStrollParams.dateTime,
        age: createStrollParams.age,
        city: createStrollParams.city,
        language: createStrollParams.language,
        gender: createStrollParams.gender.toUpperCase(),
        note: createStrollParams.note,
        title: createStrollParams.title);
    print(requestModel.toJson());
    print("SDS");
    var result = await dio.post("/strolls/create", data: requestModel.toJson());
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<List<StrollModel>> getProfileStrolls() async {
    var result = await dio.get("/profile/strolls");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      var strolls =
          (result.data as List).map((e) => StrollModel.fromJson(e)).toList();
      return strolls;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<StrollModel> getStrollById(int id) async {
    var result = await dio.get("/strolls/$id");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      var stroll = StrollModel.fromJson(result.data);
      return stroll;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<List<StrollModel>> getStrollsByUserId(int id) async {
    var result = await dio.get("/strolls/user/$id");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      var strolls =
          (result.data as List).map((e) => StrollModel.fromJson(e)).toList();
      return strolls;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<void> requestStroll(int id) async {
    var result = await dio.post("/strolls/request/$id");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<void> acceptStrollRequest(int strollId, int userId) async {
    var result = await dio.post("/strolls/accept_request",
        data: {"strollId": strollId, "userId": userId});
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<void> declineStrollRequest(int strollId, int userId) async {
    var result = await dio.post("/strolls/decline_request",
        data: {"strollId": strollId, "userId": userId});
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<List<StrollRequestModel>> getStrollRequestsById(int id) async {
    var result = await dio.get("/strolls/$id/requests");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      var requests = (result.data as List<dynamic>)
          .map((e) => StrollRequestModel.fromJson(e))
          .toList();
      return requests;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }
}
