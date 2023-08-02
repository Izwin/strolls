import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/core/network/retrofit_client.dart';
import 'package:strolls/core/network/token_interceptor.dart';
import 'package:strolls/features/auth/data/data_sources/remote_cities_datasource.dart';
import 'package:strolls/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:strolls/features/auth/domain/repositories/auth_repository.dart';
import 'package:strolls/features/auth/domain/use_cases/get_cities_use_case.dart';
import 'package:strolls/features/auth/domain/use_cases/get_languages_use_case.dart';
import 'package:strolls/features/auth/domain/use_cases/send_register_use_case.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_bloc.dart';
import 'package:strolls/features/home/data/data_sources/remote_strolls_datasource.dart';
import 'package:strolls/features/home/data/repositories/strolls_repository_impl.dart';
import 'package:strolls/features/home/domain/repositories/strolls_repository.dart';
import 'package:strolls/features/home/domain/use_cases/create_stroll_use_case.dart';
import 'package:strolls/features/home/domain/use_cases/get_strolls_use_case.dart';
import 'package:strolls/features/home/presentation/bloc/strolls_bloc.dart';
import 'package:strolls/features/profile/data/data_sources/remote_users_datasource.dart';
import 'package:strolls/features/profile/data/repositories/users_repository_impl.dart';
import 'package:strolls/features/profile/domain/repositories/users_repository.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_strolls_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/get_users_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:strolls/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:strolls/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:strolls/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';

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

  // Repository

  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(remoteCitiesDatasource: getIt()));

  getIt.registerSingleton<UserRepository>(
      UsersRepositoryImpl(remoteUsersDataSource: getIt()));

  getIt.registerSingleton<StrollsRepository>(
      StrollsRepositoryImpl(remoteStrollsDatasource: getIt()));

  // UseCase

  getIt.registerSingleton(GetCitiesUseCase(citiesRepository: getIt()));

  getIt.registerSingleton(GetLanguagesUseCase(citiesRepository: getIt()));

  getIt.registerSingleton(GetUsersUseCase(userRepository: getIt()));

  getIt.registerSingleton(GetProfileUseCase(userRepository: getIt()));

  getIt.registerSingleton(SendRegisterUseCase(authRepository: getIt()));

  getIt.registerSingleton(GetStrollsUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(CreateStrollUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(GetProfileStrollsUseCase(strollsRepository: getIt()));

  getIt.registerSingleton(UpdateProfileUseCase(userRepository: getIt()));

  getIt.registerSingleton(UploadProfileImageUseCase(userRepository: getIt()));

  // Bloc

  getIt.registerFactory(() => RegistrationBloc(
      getCitiesUseCase: getIt(), getLanguagesUseCase: getIt()));

  getIt.registerSingleton(AuthenticatorBloc(
      sendRegisterUseCase: getIt(), getProfileUseCase: getIt()));

  getIt.registerFactory(() => ProfileBloc(
      getProfileUseCase: getIt(),
      getProfileStrollsUseCase: getIt()));

  getIt.registerFactory(() => UpdateProfileBloc(
      updateProfileUseCase: getIt(),
      uploadProfileImageUseCase: getIt()));

  getIt.registerFactory(() =>
      StrollsBloc(getStrollsUseCase: getIt(), createStrollUseCase: getIt()));
}

Dio getDio() {
  var dio = Dio();
  dio.options = BaseOptions(
    baseUrl: "http://10.0.2.2:8080/api/v1/",
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
