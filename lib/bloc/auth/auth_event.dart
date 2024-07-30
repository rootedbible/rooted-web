part of "auth_bloc.dart";

@immutable
abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String username;
  final String password;
  final BuildContext context;

  SignInRequested({
    required this.context,
    required this.password,
    required this.username,
  });
}

class RegisterRequested extends AuthEvent {
  final String username;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String password;
  final BuildContext context;

  RegisterRequested({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phone,
    required this.username,
    required this.context,
  });
}

class CheckIfSignedIn extends AuthEvent {}

class RefreshUser extends AuthEvent {}

class SignOut extends AuthEvent {}
