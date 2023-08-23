part of 'friends_bloc.dart';

@immutable
abstract class FriendsState {}

class FriendsInitial extends FriendsState {}

class SentFriendRequestState extends FriendsState {}

class FriendsErrorState extends FriendsState {
  final String error;

  FriendsErrorState({required this.error});
}


class GotSentFriendshipRequestsState extends FriendsState{
  final List<FriendshipRequestEntity> requests;
  GotSentFriendshipRequestsState({required this.requests});
}

class GotFriendshipRequestsState extends FriendsState{
  final List<FriendshipRequestEntity> sentRequests;
  final List<FriendshipRequestEntity> myRequests;
  GotFriendshipRequestsState({required this.sentRequests,required this.myRequests});


}
class GotMyFriendshipRequestsState extends FriendsState{
  final List<FriendshipRequestEntity> requests;
  GotMyFriendshipRequestsState({required this.requests});
}

class ShouldUpdateState extends FriendsState {}