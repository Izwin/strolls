part of 'friends_bloc.dart';

@immutable
abstract class FriendsEvent {}

class SendFriendRequestEvent extends FriendsEvent {
  final int id;

  SendFriendRequestEvent({required this.id});
}

class AcceptFriendRequestEvent extends FriendsEvent {
  final int id;

  AcceptFriendRequestEvent({required this.id});
}

class CancelFriendRequestEvent extends FriendsEvent {
  final int id;

  CancelFriendRequestEvent({required this.id});
}

class DeleteFriendEvent extends FriendsEvent {
  final int id;

  DeleteFriendEvent({required this.id});
}

class GetMyFriendshipRequestEvent extends FriendsEvent {}

class GetFriendshipRequestEvent extends FriendsEvent {}

class GetSentFriendshipRequestEvent extends FriendsEvent {}
