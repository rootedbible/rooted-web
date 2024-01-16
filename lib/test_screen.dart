import 'package:flutter/material.dart';
import 'package:rooted_web/ui/admin/stats/helpers/user_stat_table.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: UserStatChart(),
      ),
    );
  }
}
