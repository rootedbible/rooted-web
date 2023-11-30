import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../api/api.dart';
import '../../api/responses/user_response.dart';
import '../../api/services/auth_service.dart';
import '../../api/services/users_service.dart';
import '../../models/user_model.dart';
import '../../ui/widgets/error_dialog.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  User user = User.empty;

  AuthBloc() : super(AuthUnloaded()) {
    on<SignInRequested>((event, emit) async {
      try {
        if (state is! Authenticating) {
          emit(Authenticating());
          final UserResponse userResponse = await AuthService()
              .login(username: event.username, password: event.password);

          user = userResponse.user;
          emit(Authenticated());
        }
      } catch (e) {
        debugPrint(e.toString());
        errorDialog(e.toString(), event.context);
        emit(UnAuthenticated());
      }
    });

    on<CheckIfSignedIn>((event, emit) async {
      // TODO: Update
      try {

      } catch (e) {
        debugPrint(e.toString());
        emit(UnAuthenticated());
      }
    });

    on<RefreshUser>((event, emit) async {
      try {
        user = await UsersService().getMe();
        emit(Authenticated());
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<RegisterRequested>((event, emit) async {
      try {
        emit(Authenticating());
        await UsersService().registerUser({
          'username': event.username,
          'password': event.password,
          'email': event.email,
          'first_name': event.firstName,
          'last_name': event.lastName,
          if (event.phone.trim().isNotEmpty) 'phone': event.phone,
        });
        emit(Registered());
      } catch (e) {
        debugPrint(e.toString());
        errorDialog(e.toString(), event.context);
        emit(UnAuthenticated());
      }
    });

    on<SignOut>((event, emit) async {
      await RootedApi().logout();
      user = User.empty;
      emit(UnAuthenticated());
    });
  }
}
