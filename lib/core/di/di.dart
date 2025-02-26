import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc_or_provider/auth_bloc.dart';
import '../api/api_client.dart';
import '../api/dio_client.dart';
import '../database/hive_database.dart';
import '../database/local_database.dart';
import '../utils/snackbar_utils.dart';
import '../utils/validator_util.dart';

final getIt = GetIt.instance;

/// Registers all dependencies required by the application.
///
/// This function is called once at startup in [main].
void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(
    () => DioClient(),
  );

  getIt.registerLazySingleton<LocalDatabase>(
    () => HiveDatabase(),
  );

  getIt.registerLazySingleton<ValidatorUtil>(
    () => ValidatorUtilImpl(),
  );

  getIt.registerLazySingleton<SnackbarUtil>(
    () => SnackbarUtilImpl(),
  );

  registerAuthDependencies();
}

/// Registers all dependencies required for the authentication feature.
void registerAuthDependencies() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      getIt<ApiClient>(),
    ),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
    ),
  );
}
