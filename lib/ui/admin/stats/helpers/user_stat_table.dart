import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rooted_web/const.dart';

import '../../../../models/admin/user_stat_model.dart';

class UserStatChart extends StatelessWidget {
  // final List<UserStat> userStats;

  const UserStatChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String jsonData = '''
  [
    {"count": 5, "month": 2, "year": 2023},
    {"count": 10, "month": 3, "year": 2023},
    {"count": 10, "month": 4, "year": 2023},
    {"count": 20, "month": 5, "year": 2023},
    {"count": 25, "month": 6, "year": 2023},
    {"count": 25, "month": 7, "year": 2023},
    {"count": 30, "month": 8, "year": 2023},
    {"count": 35, "month": 9, "year": 2023},
    {"count": 35, "month": 10, "year": 2023},
    {"count": 50, "month": 11, "year": 2023},
    {"count": 75, "month": 12, "year": 2023},
    {"count": 125, "month": 1, "year": 2024}
  ]
  ''';

    List<dynamic> jsonList = jsonDecode(jsonData);
    List<UserStat> userStats =
        jsonList.map((json) => UserStat.fromJson(json)).toList();

    List<FlSpot> spots = userStats
        .map(
          (stat) => FlSpot(
            (stat.year - 2020) * 12.0 + stat.month,
            stat.count.toDouble(),
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(doublePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Users',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              Expanded(
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, test) {
                            int year = 2020 + (value / 12).floor();
                            int month = (value % 12).toInt();
                            if (month == 0) {
                              month = 12;
                              year -= 1;
                            }
                            return Text(
                              '${month.toString().padLeft(2, '0')}/${year.toString().substring(2)}',
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
