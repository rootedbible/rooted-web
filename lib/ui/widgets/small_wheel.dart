import 'package:flutter/material.dart';

class SmallWheel extends StatelessWidget {
  final double? size;

  const SmallWheel({this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 12.0,
      width: size ?? 12.0,
      child: const CircularProgressIndicator(),
    );
  }
}
