import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/ui/screens/auth/auth_screen.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../home/home_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) async {
        if (state is Authenticated) {
          _navigateToHomeView(context);
        } else if (state is UnAuthenticated) {
          _navigateToLoginScreen(context);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/main_logo.png',
                  width: 250,
                  height: 250,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Rooted',
                  style: TextStyle(
                    fontFamily: 'LibreBaskerville',
                    fontSize: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHomeView(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const HomeView(),
      ),
    );
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const AuthScreen(),
      ),
    );
  }
}
