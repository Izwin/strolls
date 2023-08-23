part of 'chats_bloc.dart';

abstract class ChatsEvent {}

class GetMessagesEvent extends ChatsEvent{
  final int strollId;

  GetMessagesEvent({required this.strollId});
}

class SendMessageEvent extends ChatsEvent{
  String message;
  int strollId;

  SendMessageEvent({required this.message,required this.strollId});
}
