import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/notification/domain/entities/notification_entity.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends NotificationEntity {
  NotificationModel(
      {required super.receiverId,
      required super.id,
      required super.date,
      required super.title,
      required super.read,
      required UserModel super.sender,
      super.strollModel,
      required super.notificationType});

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
