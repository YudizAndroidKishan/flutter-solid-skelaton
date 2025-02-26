import '../../../../core/errors/error_state.dart';
import '../../domain/entities/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated({required this.user});
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState implements ErrorState {
  final dynamic _message;
  AuthError({required dynamic message}) : _message = message;

  @override
  dynamic get message => _message;
}
