import '../entities/user.dart';

/// Abstract repository for authentication.
abstract class AuthRepository {
  /// Logs the user in with [email] and [password], returning a [User].
  Future<User> login(String email, String password);

  /// Logs the user out.
  Future<void> logout();

  /// Retrieves the currently logged-in user, if any.
  Future<User?> getCurrentUser();
}
