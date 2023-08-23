part of 'chats_bloc.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

class GotMessagesState extends ChatsState {
  final List<MessageEntity> messages;

  GotMessagesState({required this.messages});
}

class GotNewMessageState extends ChatsState {
  final MessageEntity messageEntity;

  GotNewMessageState({required this.messageEntity});
}
