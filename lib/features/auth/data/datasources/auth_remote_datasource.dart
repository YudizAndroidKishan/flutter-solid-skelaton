import 'package:solid_skelaton/core/constants/api_constants.dart';
import 'package:solid_skelaton/core/database/local_database.dart';
import 'package:solid_skelaton/core/database/local_database.dart';

import '../../../../core/api/api_client.dart' show ApiClient;
import '../../../../core/di/di.dart';
import '../models/user_model.dart';

/// An interface for remote authentication data (e.g., API calls).
abstract class AuthRemoteDataSource {
  /// Attempts to log in with the provided credentials.
  Future<UserModel> login(String email, String password);

  /// Logs out the user from the remote server (if applicable).
  Future<void> logout();
}

/// A sample implementation using a hypothetical API client.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // This could be a DioClient or any HTTP client you have
  // For demonstration, we'll just pretend it's a simple object.
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String userName, String password) async {
    final response = await apiClient.post(
      ApiConstants.login,
      data: {
        'username': userName,
        'password': password,
      },
    );
    final token = response.headers.value('authorization_token');

    await getIt<LocalDatabase>().saveToken(token ?? '');
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    // Example pseudo-code for an API call:
    // await apiClient.post('/logout');
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
