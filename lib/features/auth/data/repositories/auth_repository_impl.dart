import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

/// Concrete implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    // 1. Call remote datasource
    final UserModel userModel = await remoteDataSource.login(
      email,
      password,
    );
    // 2. Cache the user locally
    await localDataSource.cacheUser(userModel);
    // 3. Return domain entity
    return userModel;
  }

  @override
  Future<void> logout() async {
    // 1. Call remote logout
    await remoteDataSource.logout();
    // 2. Clear local data
    await localDataSource.clearUser();
  }

  @override
  Future<User?> getCurrentUser() async {
    final UserModel? userModel = await localDataSource.getCachedUser();
    return userModel;
  }
}
