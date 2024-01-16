import 'package:flutter/material.dart';
import 'package:rooted_web/const.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width <= mobileWidth;
    return Scaffold(
      body: Column(
        children: [
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(flex: isMobile ? 0: 1, child: const Text('Test')),
              Expanded(flex: isMobile ? 0: 1, child: const Text('Test')),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTotalUsers() {
    return const Column(
      children: [Text('Total Users')],
    );
  }
}
