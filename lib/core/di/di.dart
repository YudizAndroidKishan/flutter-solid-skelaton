import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:solid_skelaton/features/leave_listing/data/datasources/leave_listing_remote_datasource.dart';
import 'package:solid_skelaton/features/leave_listing/data/repositories/leave_listing_repository_impl.dart';
import 'package:solid_skelaton/features/leave_listing/domain/repositories/leave_listing_repository.dart';
import 'package:solid_skelaton/features/leave_listing/domain/usecases/get_leave_usecase.dart';
import 'package:solid_skelaton/features/leave_listing/presentation/bloc/leave_listing_bloc.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc_or_provider/auth_bloc.dart';
import '../../features/home/presentation/bloc_or_provider/home_bloc.dart';
import '../api/api_client.dart';
import '../api/dio_client.dart';
import '../database/hive_database.dart';
import '../database/local_database.dart';
import '../navigation/go_router_service.dart';
import '../navigation/router_service.dart';
import '../utils/snackbar_utils.dart';
import '../utils/validator_util.dart';

final getIt = GetIt.instance;

/// Registers all dependencies required by the application.
///
/// This function is called once at startup in [main].
Future<void> setupDependencies() async {
  await setupLocalStorageDI();

  getIt.registerLazySingleton<RouterService>(
    () => GoRouterService(),
  );

  getIt.registerLazySingleton<ValidatorUtil>(
    () => ValidatorUtilImpl(),
  );

  getIt.registerLazySingleton<SnackbarUtil>(
    () => SnackbarUtilImpl(),
  );

  getIt.registerLazySingleton<ApiClient>(
    () => DioClient(),
  );

  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(),
  );

  registerAuthDependencies();
  registerLeaveListingDI();
}

void registerLeaveListingDI() {
  // Register data sources
  getIt.registerLazySingleton<LeaveListingRemoteDataSource>(
    () => LeaveListingRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );

  // Register repository
  getIt.registerLazySingleton<LeaveListingRepository>(
    () => LeaveListingRepositoryImpl(
        remoteDataSource: getIt<LeaveListingRemoteDataSource>()),
  );

  // Register use case
  getIt.registerLazySingleton<GetLeaveUseCase>(
    () => GetLeaveUseCase(repository: getIt<LeaveListingRepository>()),
  );

  // Register bloc
  getIt.registerFactory<LeaveListingBloc>(
    () => LeaveListingBloc(getLeaveUseCase: getIt<GetLeaveUseCase>()),
  );
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

Future<void> setupLocalStorageDI() async {
  getIt.registerLazySingleton<LocalDatabase>(
    () => HiveDatabase(),
  );

  WidgetsFlutterBinding.ensureInitialized();
  final localDb = getIt<LocalDatabase>();
  await localDb.init();
}
