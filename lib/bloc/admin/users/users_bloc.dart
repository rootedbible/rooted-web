import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../api/services/users_service.dart';
import '../../../models/user_model.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  String? previousQuery;
  int page = 0;
  bool hasMore = true;
  List<User> users = [];

  UsersBloc() : super(const UsersLoaded(users: [])) {
    on<GetUsers>((event, emit) async {
      if (state is! UsersLoading) {
        try {
          emit(UsersLoading(users: users));
          if (previousQuery != event.query) {
            previousQuery = event.query;
            page = 0;
            hasMore = true;
            users = [];
          }
          if (hasMore) {
            final newUsers = (await UsersService()
                    .searchUsers(query: event.query, page: page))
                .users;
            hasMore = newUsers.length == 20;
            users.addAll(newUsers);
            page++;
          }
          for (User user in users) {
            print(user.firstName + " " + user.lastName);
          }
          emit(UsersLoaded(users: users));
        } catch (e) {
          debugPrint('Error getting users: $e');
          emit(UsersError(error: e.toString(), users: users));
        }
      }
    });
  }
}
