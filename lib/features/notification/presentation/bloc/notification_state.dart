part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationsErrorState extends NotificationState{
  final String error;
  NotificationsErrorState({required this.error});
}

class GotNotificationsState extends NotificationState{
  final List<NotificationEntity> notifications;
  GotNotificationsState({required this.notifications});
 }

 class NotificationAcceptedAllDeclinedState extends NotificationState{}