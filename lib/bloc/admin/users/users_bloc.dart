
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  List<User> users = [];

  UsersBloc() : super(UsersInitial()) {
    on<UsersEvent>((event, emit) {

    });
  }
}
