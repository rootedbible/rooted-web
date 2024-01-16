import 'package:rooted_web/models/admin/report_model.dart';

class ReportsResponse {
  final List<Report> reports;

  ReportsResponse({required this.reports});

  factory ReportsResponse.fromJson(List<dynamic> json) {
    List<Report> reports = [];
    for (Map<String, dynamic> report in json) {
      reports.add(Report.fromJson(report));
    }
    return ReportsResponse(reports: reports);
  }
}
