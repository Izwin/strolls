import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationRepository{
  Future<Either<Failure,List<NotificationEntity>>> getNotifications();
  Future<Either<Failure,void>> acceptNotification(int id);
  Future<Either<Failure,void>> declineNotification(int id);
}