import 'package:solid_skelaton/core/database/local_database.dart';
import 'package:solid_skelaton/core/di/di.dart';

import '../models/user_model.dart';

/// An interface for local authentication data (e.g., storing tokens).
abstract class AuthLocalDataSource {
  /// Stores the currently logged-in user data locally.
  Future<void> cacheUser(UserModel user);

  /// Retrieves the cached user, if any.
  Future<UserModel?> getCachedUser();

  /// Removes the cached user data (logout).
  Future<void> clearUser();
}

/// A sample implementation using a local database or SharedPreferences/Hive, etc.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> cacheUser(UserModel user) async {
    getIt<LocalDatabase>().setUser(user.toJson());
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = await getIt<LocalDatabase>().getUser();
    if (userJson == null) return null;
    return UserModel.fromJson(userJson);
  }

  @override
  Future<void> clearUser() async {
    getIt<LocalDatabase>().removeUser();
  }
}
