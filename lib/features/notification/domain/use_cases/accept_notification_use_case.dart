import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/notifications_repository.dart';

class AcceptNotificationUseCase{
  final NotificationRepository notificationRepository;
  AcceptNotificationUseCase({required this.notificationRepository});

  Future<Either<Failure,void>> call(int id){
    return notificationRepository.acceptNotification(id);
  }
}