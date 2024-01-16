import 'package:flutter/material.dart';

class PercentageTree extends StatelessWidget {
  final double percentage;

  const PercentageTree({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // or specify your image width
      height: double.infinity, // or specify your image height
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRect(
            clipper: _PercentageClipper(percentage),
            child: Image.asset('assets/images/gold_filled.png'),
          ),
          Image.asset('assets/images/main_logo.png'),
        ],
      ),
    );
  }
}

class _PercentageClipper extends CustomClipper<Rect> {
  final double percentage;

  _PercentageClipper(this.percentage);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      0,
      size.height * (1 - percentage / 100),
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(_PercentageClipper oldClipper) {
    return percentage != oldClipper.percentage;
  }
}
