import 'package:strolls/features/profile/domain/entities/user_entity.dart';

class NotificationEntity {
  final int id;
  final String notificationType;
  final String title;
  final bool read;
  final DateTime date;
  final int receiverId;
  final UserEntity sender;
  final int? strollModel;

  NotificationEntity(
      {required this.receiverId,
      required this.id,
      required this.date,
      required this.title,
      required this.read,
      required this.sender,
      this.strollModel,
      required this.notificationType});
}
