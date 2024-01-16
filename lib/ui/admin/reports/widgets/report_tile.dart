import 'package:flutter/material.dart';
import 'package:rooted_web/api/services/users_service.dart';
import 'package:rooted_web/ui/admin/reports/other_profile_screen.dart';

import '../../../../models/admin/report_model.dart';

class ReportTile extends StatefulWidget {
  final Report report;

  const ReportTile({required this.report, super.key});

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  late Report report;

  @override
  void initState() {
    super.initState();
    report = widget.report;
  }

  IconData _getReasonIcon() {
    switch (report.type) {
      case 'user':
        return Icons.account_circle;
      case 'recording':
        return Icons.mic;
      case 'organization':
        return Icons.groups;
      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_getReasonIcon()),
      title: Text(report.comment),
      onTap: () async {
        switch (report.type) {
          case 'user':
            final user =
                await UsersService().getUserById(id: report.reportedEntityId);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtherProfileScreen(user),),);
            break;
          case 'recording':
            // TODO: List of audio urls
            break;
          case 'organization':
            // TODO: Go to organization screen
            break;
          default:
            break;
        }
      },
    );
  }
}
