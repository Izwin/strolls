import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/notification/domain/entities/notification_entity.dart';
import 'package:strolls/features/notification/domain/repositories/notifications_repository.dart';

class GetNotificationsUseCase{
  final NotificationRepository notificationRepository;

  GetNotificationsUseCase({required this.notificationRepository});

  Future<Either<Failure,List<NotificationEntity>>> call(){
    return notificationRepository.getNotifications();
  }
}