part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {}

class UsersError extends UsersState {
  final String error;

  UsersError({required this.error});
}
