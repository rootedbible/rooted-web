import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  final Color? color;
  final double? height;

  const DividerLine({this.color = Colors.grey, this.height = 0.5, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 0.5,
      color: color ?? Colors.grey,
    );
  }
}
