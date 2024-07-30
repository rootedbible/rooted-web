part of "users_bloc.dart";

@immutable
abstract class UsersEvent {}

class GetUsers extends UsersEvent {
  final String query;

  GetUsers({required this.query});
}
