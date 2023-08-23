import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/friendship_request_entity.dart';

part 'friendship_request_model.g.dart';

@JsonSerializable()
class FriendshipRequestModel extends FriendshipRequestEntity {
  FriendshipRequestModel({required super.dateTime, required super.senderId,required super.receiverId});

  factory FriendshipRequestModel.fromJson(Map<String,dynamic> json) => _$FriendshipRequestModelFromJson(json);

  Map<String,dynamic> toJson() => _$FriendshipRequestModelToJson(this);
}
