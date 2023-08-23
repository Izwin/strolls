import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/profile/domain/entities/friendship_request_entity.dart';
import 'package:strolls/features/profile/domain/use_cases/accept_friends_request_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/cancel_friend_request_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/delete_friend_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_my_friendship_requests_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_use_case.dart';

import '../../../domain/use_cases/get_sent_friendship_requests_use_case.dart';
import '../../../domain/use_cases/send_friend_request_use_case.dart';

part 'friends_event.dart';

part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final SendFriendRequestUseCase sendFriendRequestUseCase;
  final GetMyFriendshipRequestsUseCase getMyFriendshipRequestsUseCase;
  final GetSentFriendshipRequestsUseCase getSentFriendshipRequestsUseCase;
  final AcceptFriendRequestUseCase acceptFriendRequestUseCase;
  final CancelFriendRequestUseCase cancelFriendRequestUseCase;
  final GetProfileUseCase getProfileUseCase;
  final DeleteFriendUseCase deleteFriendUseCase;

  FriendsBloc(
      {required this.sendFriendRequestUseCase,
      required this.getSentFriendshipRequestsUseCase,
      required this.acceptFriendRequestUseCase,
      required this.cancelFriendRequestUseCase,
      required this.deleteFriendUseCase,
      required this.getProfileUseCase,
      required this.getMyFriendshipRequestsUseCase})
      : super(FriendsInitial()) {
    on<SendFriendRequestEvent>(_onSendFriendRequestEvent);
    on<GetSentFriendshipRequestEvent>(_onGetSentFriendshipRequestEvent);
    on<GetFriendshipRequestEvent>(_onGetFriendshipRequestEvent);
    on<AcceptFriendRequestEvent>(_onAcceptFriendRequestEvent);
    on<GetMyFriendshipRequestEvent>(_onGetMyFriendshipRequestEvent);
    on<CancelFriendRequestEvent>(_onCancelFriendshipRequestEvent);
    on<DeleteFriendEvent>(_onDeleteFriendEvent);
  }

  Future<void> _onSendFriendRequestEvent(
      SendFriendRequestEvent event, Emitter emitter) async {
    var result = await sendFriendRequestUseCase(event.id);
    result.fold((l) {
      emit(FriendsErrorState(error: "Error"));
    }, (r) async {
      emit(ShouldUpdateState());
    });
  }

  Future<void> _onGetSentFriendshipRequestEvent(
      GetSentFriendshipRequestEvent event, Emitter emitter) async {
    var result = await getSentFriendshipRequestsUseCase();
    result.fold((l) {
      emit(FriendsErrorState(error: "Error"));
    }, (r) {
      emit(GotSentFriendshipRequestsState(requests: r));
    });
  }

  Future<void> _onGetFriendshipRequestEvent(
      GetFriendshipRequestEvent event, Emitter emitter) async {
    var sentRequests = await getSentFriendshipRequestsUseCase();
    var myRequests = await getMyFriendshipRequestsUseCase();
    if (sentRequests.isRight() && myRequests.isRight()) {
      emit(GotFriendshipRequestsState(
          sentRequests: sentRequests.getOrElse(() => []),
          myRequests: myRequests.getOrElse(() => [])));
    } else {
      emit(FriendsErrorState(error: "Error"));
    }
  }

  Future<void> _onAcceptFriendRequestEvent(
      AcceptFriendRequestEvent event, Emitter emitter) async {
    var result = await acceptFriendRequestUseCase(event.id);
    result.fold((l) {
      emit(FriendsErrorState(error: "Error"));
    }, (r) async {
      emit(ShouldUpdateState());

    });
  }

  Future<void> _onGetMyFriendshipRequestEvent(
      GetMyFriendshipRequestEvent event, Emitter emitter) async {
    var result = await getMyFriendshipRequestsUseCase();
    result.fold((l) {
      emit(FriendsErrorState(error: "Error"));
    }, (r) {
      emit(GotMyFriendshipRequestsState(requests: r));
    });
  }

  Future<void> _onCancelFriendshipRequestEvent(
      CancelFriendRequestEvent event, Emitter emitter) async {
    var result = await cancelFriendRequestUseCase(event.id);
    result.fold((l) {
      emit(FriendsErrorState(error: "Error"));
    }, (r) async {
      emit(ShouldUpdateState());

    });
  }

  Future<void> _onDeleteFriendEvent(
      DeleteFriendEvent event, Emitter emitter) async {
    var result = await deleteFriendUseCase(event.id);
    result.fold((l) {
      emit(FriendsErrorState(error: "Error"));
    }, (r) async {
      emit(ShouldUpdateState());

    });
  }
}
