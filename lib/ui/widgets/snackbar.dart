import 'package:flutter/material.dart';

void snackbar(BuildContext context, String text) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(text),
      duration: const Duration(seconds: 3),
    ),
  );
}
