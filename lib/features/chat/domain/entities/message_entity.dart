import 'package:strolls/features/profile/domain/entities/user_entity.dart';

class MessageEntity {
  int id;
  int userId;
  String? userAvatar;
  String username;
  DateTime? dateTime;
  String type;
  String message;

  MessageEntity({
    required this.userId,
    required this.username,
    this.userAvatar,
    required this.id,
    required this.message,
    required this.type,
    this.dateTime,
  });
}
