import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/const.dart';
import 'package:rooted_web/ui/admin/stats/helpers/user_stat_table.dart';

import '../../../bloc/admin/stats/stats_bloc.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    context.read<StatsBloc>().add(GetStats());
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width <= mobileWidth;
    return BlocConsumer<StatsBloc, StatsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is! StatsLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(doublePadding),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(doublePadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'STATS:',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Subscription Counts: (In Progress)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Total Minutes Recorded: ${context.read<StatsBloc>().totalMinutes}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            buildTotalUsers(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget buildTotalUsers() {
    return const Column(
      children: [UserStatChart()],
    );
  }
}
