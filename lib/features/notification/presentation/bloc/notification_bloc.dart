import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:strolls/features/home/domain/use_cases/decline_stroll_request_use_case.dart';
import 'package:strolls/features/notification/domain/use_cases/accept_notification_use_case.dart';
import 'package:strolls/features/notification/domain/use_cases/decline_notification_use_case.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  GetNotificationsUseCase getNotificationsUseCase;
  AcceptNotificationUseCase acceptNotificationUseCase;
  DeclineNotificationUseCase declineNotificationUseCase;

  NotificationBloc(
      {required this.getNotificationsUseCase,
      required this.declineNotificationUseCase,
      required this.acceptNotificationUseCase})
      : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_onGetNotificationsEvent);
    on<DeclineNotificationEvent>(_onDeclineNotificationEvent);
    on<AcceptNotificationEvent>(_onAcceptNotificationEvent);
  }

  Future<void> _onGetNotificationsEvent(
      GetNotificationsEvent getNotificationsEvent, Emitter emitter) async {
    var result = await getNotificationsUseCase();

    result.fold((l) {
      emit(NotificationsErrorState(error: l.message));
    }, (r) {
      emit(GotNotificationsState(notifications: r));
    });
  }

  Future<void> _onAcceptNotificationEvent(
      AcceptNotificationEvent acceptNotificationEvent, Emitter emitter) async {
    var result = await acceptNotificationUseCase(acceptNotificationEvent.id);

    result.fold((l) {
      emit(NotificationsErrorState(error: l.message));
    }, (r) {
      emit(NotificationAcceptedAllDeclinedState());
    });
  }

  Future<void> _onDeclineNotificationEvent(
      DeclineNotificationEvent declineNotificationEvent, Emitter emitter) async {
    var result = await declineNotificationUseCase(declineNotificationEvent.id);

    result.fold((l) {
      emit(NotificationsErrorState(error: l.message));
    }, (r) {
      emit(NotificationAcceptedAllDeclinedState());
    });
  }
}
