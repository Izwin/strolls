import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/chat/domain/repositories/chats_repository.dart';

class SendMessageUseCase{
  final ChatRepository chatRepository;
  SendMessageUseCase({required this.chatRepository});


  Future<Either<Failure, void>> call(String message,int strollId){
      return chatRepository.sendMessage(message,strollId);
  }
}