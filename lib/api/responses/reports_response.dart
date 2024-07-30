import "package:rooted_web/models/admin/report_model.dart";

class ReportsResponse {
  final List<Report> reports;

  ReportsResponse({required this.reports});

  factory ReportsResponse.fromJson(List<dynamic> json) {
    final List<Report> reports = [];
    for (final Map<String, dynamic> report in json) {
      reports.add(Report.fromJson(report));
    }
    return ReportsResponse(reports: reports);
  }
}
