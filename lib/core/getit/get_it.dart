import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/core/network/host_data.dart';
import 'package:strolls/core/network/retrofit_client.dart';
import 'package:strolls/core/network/token_interceptor.dart';
import 'package:strolls/features/auth/data/data_sources/remote_cities_datasource.dart';
import 'package:strolls/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';
import 'package:strolls/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:strolls/features/auth/domain/use_cases/get_cities_use_case.dart';
import 'package:strolls/features/auth/domain/use_cases/get_languages_use_case.dart';
import 'package:strolls/features/auth/domain/use_cases/send_register_use_case.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_bloc.dart';
import 'package:strolls/features/chat/data/data_sources/remote_chats_data_source.dart';
import 'package:strolls/features/chat/data/repositories/chats_repository_impl.dart';
import 'package:strolls/features/chat/domain/repositories/chats_repository.dart';
import 'package:strolls/features/chat/domain/use_cases/get_messages_use_case.dart';
import 'package:strolls/features/chat/domain/use_cases/send_message_use_case.dart';
import 'package:strolls/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:strolls/features/home/data/data_sources/remote_strolls_datasource.dart';
import 'package:strolls/features/home/data/repositories/strolls_repository_impl.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';
import 'package:strolls/features/home/domain/use_cases/accept_stroll_request_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/create_stroll_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/get_stroll_by_id_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/get_stroll_requests_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/get_strolls_by_user_id_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/get_strolls_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/request_stroll_use_case.dart';
import 'package:strolls/features/home/presentation/bloc/stroll_single/stroll_single_bloc.dart';
import 'package:strolls/features/home/presentation/bloc/strolls_bloc.dart';
import 'package:strolls/features/notification/data/data_sources/remote_notification_datasource.dart';
import 'package:strolls/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:strolls/features/notification/domain/repositories/notifications_repository.dart';
import 'package:strolls/features/notification/domain/use_cases/accept_notification_use_case.dart';
import 'package:strolls/features/notification/domain/use_cases/decline_notification_use_case.dart';
import 'package:strolls/features/notification/domain/use_cases/get_notifications_use_case.dart';
import 'package:strolls/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:strolls/features/profile/data/data_sources/remote_users_datasource.dart';
import 'package:strolls/features/profile/data/repositories/users_repository_impl.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';
import 'package:strolls/features/profile/domain/use_cases/accept_friends_request_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/cancel_friend_request_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/delete_friend_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_my_friendship_requests_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_by_id_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_strolls_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_sent_friendship_requests_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_users_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/send_friend_request_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:strolls/features/profile/presentation/bloc/friends/friends_bloc.dart';
import 'package:strolls/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:strolls/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';

import '../../features/home/domain/use_cases/decline_stroll_request_use_case.dart';

var getIt = GetIt.instance;

void setup() {
  // Network
  getIt.registerSingleton(getDio());
  getIt.registerSingleton(RetrofitClient(getIt()));

  // Datasource

  getIt.registerSingleton<RemoteCitiesDatasource>(
      RemoteCitiesDatasource(retrofitClient: getIt(), dio: getIt()));

  getIt.registerSingleton<RemoteUsersDatasource>(
      RemoteUsersDatasource(retrofitClient: getIt(), dio: getIt()));

  getIt.registerSingleton<RemoteStrollsDatasource>(
      RemoteStrollsDatasource(dio: getIt()));

  getIt.registerSingleton<RemoteNotificationDatasource>(
      RemoteNotificationDatasource(dio: getIt()));

  getIt.registerSingleton<RemoteChatsDataSource>(
      RemoteChatsDataSource(dio: getIt()));
  // Repository

  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(remoteCitiesDatasource: getIt()));

  getIt.registerSingleton<UserRepository>(
      UsersRepositoryImpl(remoteUsersDataSource: getIt()));

  getIt.registerSingleton<StrollsRepository>(
      StrollsRepositoryImpl(remoteStrollsDatasource: getIt()));

  getIt.registerSingleton<NotificationRepository>(
      NotificationRepositoryImpl(remoteNotificationDatasource: getIt()));

  getIt.registerSingleton<ChatRepository>(
      ChatsRepositoryImpl(remoteChatsDataSource: getIt()));

  // UseCase

  getIt.registerSingleton(GetCitiesUseCase(citiesRepository: getIt()));

  getIt.registerSingleton(GetLanguagesUseCase(citiesRepository: getIt()));

  getIt.registerSingleton(GetUsersUseCase(userRepository: getIt()));

  getIt.registerSingleton(GetProfileUseCase(userRepository: getIt()));

  getIt.registerSingleton(SendRegisterUseCase(authRepository: getIt()));

  getIt.registerSingleton(AuthUseCase(authRepository: getIt()));

  getIt.registerSingleton(GetStrollsUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(GetStrollByIdUseCase(strollsRepository: getIt()));

  getIt
      .registerSingleton(GetStrollsByUserIdUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(SendFriendRequestUseCase(userRepository: getIt()));

  getIt.registerSingleton(
      GetSentFriendshipRequestsUseCase(userRepository: getIt()));

  getIt.registerSingleton(
      GetMyFriendshipRequestsUseCase(userRepository: getIt()));

  getIt.registerSingleton(CreateStrollUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(AcceptFriendRequestUseCase(userRepository: getIt()));

  getIt.registerSingleton(GetProfileStrollsUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(UpdateProfileUseCase(userRepository: getIt()));

  getIt.registerSingleton(RequestStrollUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(UploadProfileImageUseCase(userRepository: getIt()));

  getIt.registerSingleton(GetStrollRequestsUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(
      AcceptStrollRequestUseCase(strollsRepository: getIt()));
  getIt.registerSingleton(DeleteFriendUseCase(userRepository: getIt()));
  getIt.registerSingleton(CancelFriendRequestUseCase(userRepository: getIt()));

  getIt.registerSingleton(
      DeclineStrollRequestUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(GetProfileByIdUseCase(userRepository: getIt()));
  getIt.registerSingleton(SendMessageUseCase(chatRepository: getIt()));
  getIt.registerSingleton(
      AcceptNotificationUseCase(notificationRepository: getIt()));
  getIt.registerSingleton(
      DeclineNotificationUseCase(notificationRepository: getIt()));

  getIt.registerSingleton(
      GetNotificationsUseCase(notificationRepository: getIt()));

  getIt.registerSingleton(GetMessagesUseCase(chatRepository: getIt()));

  // Bloc

  getIt.registerFactory(() => RegistrationBloc(
      getCitiesUseCase: getIt(), getLanguagesUseCase: getIt()));

  getIt.registerSingleton(AuthenticatorBloc(
      sendRegisterUseCase: getIt(),
      getProfileUseCase: getIt(),
      authUseCase: getIt()));

  getIt.registerFactory(() => ProfileBloc(
      getProfileUseCase: getIt(),
      getProfileStrollsUseCase: getIt(),
      getProfileByIdUseCase: getIt()));

  getIt.registerFactory(() => FriendsBloc(
      sendFriendRequestUseCase: getIt(),
      acceptFriendRequestUseCase: getIt(),
      cancelFriendRequestUseCase: getIt(),
      getProfileUseCase: getIt(),
      deleteFriendUseCase: getIt(),
      getSentFriendshipRequestsUseCase: getIt(),
      getMyFriendshipRequestsUseCase: getIt()));

  getIt.registerFactory(() => UpdateProfileBloc(
      updateProfileUseCase: getIt(), uploadProfileImageUseCase: getIt()));

  getIt.registerFactory(() => StrollsBloc(
      getStrollsUseCase: getIt(),
      createStrollUseCase: getIt(),
      getStrollsByUserIdUseCase: getIt()));

  getIt.registerFactory(() => StrollSingleBloc(
      getStrollByIdUseCase: getIt(),
      getStrollRequestsUseCase: getIt(),
      acceptStrollRequestUseCase: getIt(),
      declineStrollRequestUseCase: getIt(),
      requestStrollUseCase: getIt()));

  getIt.registerFactory(() => NotificationBloc(
      getNotificationsUseCase: getIt(),
      declineNotificationUseCase: getIt(),
      acceptNotificationUseCase: getIt()));

  getIt.registerFactory(() =>
      ChatsBloc(getMessagesUseCase: getIt(), sendMessageUseCase: getIt()));
}

Dio getDio() {
  var dio = Dio();
  dio.options = BaseOptions(
    baseUrl: HostData.HOST,
    receiveTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );

  dio.interceptors.add(TokenInterceptor(dio));

  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      request: true,
      responseHeader: true,
      responseBody: true));

  return dio;
}
