import 'package:dio/dio.dart';
import 'package:strolls/features/notification/data/models/notification_model.dart';

import '../../../../core/error/my_server_exception.dart';

class RemoteNotificationDatasource{
  final Dio dio;

  RemoteNotificationDatasource({required this.dio});

  Future<List<NotificationModel>> getNotifications() async {
    var result = await dio.get("/notifications");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      var strolls =
      (result.data as List).map((e) => NotificationModel.fromJson(e)).toList();
      return strolls;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }

  Future<void> acceptNotification(int id) async {
    var result = await dio.get("/notifications/$id/accept");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }
  Future<void> declineNotification(int id) async {
    var result = await dio.get("/notifications/$id/decline");
    if (result.statusCode! >= 200 || result.statusCode! <= 300) {
      return;
    } else {
      throw MyServerException(message: result.data["errorMessage"]);
    }
  }
}