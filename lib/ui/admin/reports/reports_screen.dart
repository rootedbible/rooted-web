import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:rooted_web/bloc/admin/reports/reports_bloc.dart";
import "package:rooted_web/ui/admin/reports/widgets/report_tile.dart";

import "../../../const.dart";
import "../../../models/admin/report_model.dart";

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReportsBloc>().add(GetReports());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportsBloc, ReportsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(doublePadding),
                child: Text(
                  "Reports",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<ReportsBloc>().reports.length,
                  itemBuilder: (context, index) {
                    final Report report =
                        context.read<ReportsBloc>().reports[index];
                    return ReportTile(report: report);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
