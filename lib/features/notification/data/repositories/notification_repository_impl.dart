import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/core/error/my_server_exception.dart';
import 'package:strolls/features/notification/data/data_sources/remote_notification_datasource.dart';
import 'package:strolls/features/notification/domain/entities/notification_entity.dart';
import 'package:strolls/features/notification/domain/repositories/notifications_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository{
  final RemoteNotificationDatasource remoteNotificationDatasource;
  NotificationRepositoryImpl({required this.remoteNotificationDatasource});


  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try{
      return Right(await remoteNotificationDatasource.getNotifications());
    }
    on MyServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> acceptNotification(int id) async{
    try{
      return Right(await remoteNotificationDatasource.acceptNotification(id));
    }
    on MyServerException catch (e) {
    return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> declineNotification(int id) async {
    try{
      return Right(await remoteNotificationDatasource.declineNotification(id));
    }
    on MyServerException catch (e) {
    return Left(Failure(message: e.message));
    }
  }

}