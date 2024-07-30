part of "auth_bloc.dart";

@immutable
abstract class AuthState {}

class AuthUnloaded extends AuthState {}

class UnAuthenticated extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {}

class Registered extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}
