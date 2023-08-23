import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/message_entity.dart';
import '../../domain/use_cases/get_messages_use_case.dart';
import '../../domain/use_cases/send_message_use_case.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  ChatsBloc({required this.getMessagesUseCase,required this.sendMessageUseCase}) : super(ChatsInitial()) {
    on<GetMessagesEvent>(_onGetMessagesEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  Future<void> _onGetMessagesEvent(GetMessagesEvent getMessagesEvent,Emitter emitter) async{
    await getMessagesUseCase.call(getMessagesEvent.strollId,(m){
      emit(GotMessagesState(messages: m));
    },(m) {
      emit(GotNewMessageState(messageEntity: m));
    });
  }

  Future<void> _onSendMessageEvent(SendMessageEvent sendMessageEvent,Emitter emitter) async{
    await sendMessageUseCase.call(sendMessageEvent.message,sendMessageEvent.strollId);
  }
}
