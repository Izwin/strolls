import 'package:dartz/dartz.dart';
import 'package:strolls/core/error/failure.dart';
import 'package:strolls/features/chat/data/data_sources/remote_chats_data_source.dart';
import 'package:strolls/features/chat/domain/entities/message_entity.dart';
import 'package:strolls/features/chat/domain/repositories/chats_repository.dart';

class ChatsRepositoryImpl extends ChatRepository{
  final RemoteChatsDataSource remoteChatsDataSource;
  ChatsRepositoryImpl({required this.remoteChatsDataSource});
  @override
  Future<Either<Failure, void>> getMessages(int strollId, Function(List<MessageEntity> p1) onGotMessages,Function(MessageEntity p1) onGotMessage) async {
    await remoteChatsDataSource.getMessages(strollId, onGotMessages,onGotMessage);
    return Right(1);
  }

  @override
  Future<Either<Failure, void>> sendMessage(String message,int strollId) async{
    await remoteChatsDataSource.sendMessage(strollId,message);
    return Right(1);
  }

}