part of "users_bloc.dart";

@immutable
abstract class UsersState {
  final List<User> users;
  const UsersState({required this.users});
}

class UsersLoading extends UsersState {
  const UsersLoading({required super.users});
}

class UsersLoaded extends UsersState {
  const UsersLoaded({required super.users});
}

class UsersError extends UsersState {
  final String error;

  const UsersError({required this.error, required super.users});
}
