import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/chat/domain/entities/message_entity.dart';

import '../repositories/chats_repository.dart';

class GetMessagesUseCase {
  final ChatRepository chatRepository;

  GetMessagesUseCase({required this.chatRepository});

  Future<Either<Failure, void>> call(int strollId,Function(List<MessageEntity>) onGotMessages, Function(MessageEntity) onGotMessage) {
    return chatRepository.getMessages(strollId,onGotMessages,onGotMessage);
  }
}
