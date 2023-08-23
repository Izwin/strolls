import 'package:dartz/dartz.dart';
import 'package:strolls/features/chat/domain/entities/message_entity.dart';

import '../../../../core/error/failure.dart';

abstract class ChatRepository{
  Future<Either<Failure,void>> getMessages(int strollId,Function(List<MessageEntity>) onGotMessages,Function(MessageEntity) onGotMessage);
  Future<Either<Failure,void>> sendMessage(String message,int strollId);
}