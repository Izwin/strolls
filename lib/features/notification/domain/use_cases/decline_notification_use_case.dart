import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/notifications_repository.dart';

class DeclineNotificationUseCase{
  final NotificationRepository notificationRepository;
  DeclineNotificationUseCase({required this.notificationRepository});

  Future<Either<Failure,void>> call(int id){
    return notificationRepository.declineNotification(id);
  }
}