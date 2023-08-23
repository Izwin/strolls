part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetNotificationsEvent extends NotificationEvent {}

class AcceptNotificationEvent extends NotificationEvent {
  final int id;
  AcceptNotificationEvent({required this.id});
}

class DeclineNotificationEvent extends NotificationEvent {
  final int id;
  DeclineNotificationEvent({required this.id});
}