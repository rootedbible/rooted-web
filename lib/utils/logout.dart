import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/bloc/auth/auth_bloc.dart';
import 'package:rooted_web/const.dart';
import 'package:rooted_web/ui/screens/auth/auth_screen.dart';

Future<void> logout(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(doublePadding),
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                'Logout?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text('Are you sure you want to logout?'),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => _handleLogout(context),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void _handleLogout(BuildContext context) {
  context.read<AuthBloc>().add(SignOut());
  Navigator.popUntil(context, (route) => route.isFirst);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const AuthScreen()),
  );
}
