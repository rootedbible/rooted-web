import 'package:flutter/material.dart';

class LoadingMessage extends StatelessWidget {
  final String text;

  const LoadingMessage(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
