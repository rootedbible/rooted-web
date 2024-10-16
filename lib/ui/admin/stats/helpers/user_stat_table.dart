import "dart:math";

import "package:collection/collection.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:rooted_web/bloc/admin/stats/stats_bloc.dart";
import "package:rooted_web/models/admin/stat_point.dart";

import "../../../../const.dart";
import "../../../../models/admin/user_stat_model.dart";

class UserStatChart extends StatelessWidget {
  const UserStatChart({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.read<StatsBloc>().userStats;
    final List<StatPoint> points = getStatPoints(stats);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "User Counts By Month",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            height: 300,
            width: 600,
            child: LineChart(
              LineChartData(
                maxY: (stats.map((stat) => stat.count).reduce(max).toDouble() *
                        1.5)
                    .round()
                    .toDouble(),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    preventCurveOverShooting: true,
                    spots: points
                        .map((point) => FlSpot(point.x, point.y))
                        .toList(),
                    dotData: FlDotData(
                      checkToShowDot: (spot, barData) {
                        return true;
                      },
                      getDotPainter: (spot, percent, barData, index) {
                        final bool isLoss = index != 0 &&
                            points
                                    .map((point) => FlSpot(point.x, point.y))
                                    .toList()[index - 1]
                                    .y >
                                points
                                    .map((point) => FlSpot(point.x, point.y))
                                    .toList()[index]
                                    .y;
                        return FlDotCirclePainter(
                          radius: 4,
                          color: isLoss
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context)
                                  .colorScheme
                                  .primary, // Conditional color
                          strokeWidth: 1,
                          strokeColor: Theme.of(context).colorScheme.surface,
                        );
                      },
                    ),
                  ),
                ],
                titlesData: FlTitlesData(
                  // Disable top and right titles
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // Customize bottom titles to show whole numbers only
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        // Check if value is a whole number
                        final isWholeNumber = value % 1 == 0;
                        return Text(
                          isWholeNumber
                              ? "${stats[value.toInt()].month}/${stats[value.toInt()].year}"
                              : "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: const FlGridData(show: false), // Disable grid lines
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<StatPoint> getStatPoints(List<UserStat> stats) {
    return stats
        .mapIndexed(
          (index, element) =>
              StatPoint(x: index.toDouble(), y: element.count.toDouble()),
        )
        .toList();
  }
}
