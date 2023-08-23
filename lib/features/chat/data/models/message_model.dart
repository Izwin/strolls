import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:strolls/features/chat/domain/entities/message_entity.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends MessageEntity {
  MessageModel({required super.userId, required super.username, super.userAvatar, required super.id, required super.message, required super.type, super.dateTime});

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

}
