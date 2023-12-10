import 'package:flutter/cupertino.dart';
import 'package:rooted_web/ui/widgets/divider_line.dart';

class ReportTile extends StatelessWidget {
  final String message;
  final Widget data;

  const ReportTile({required this.data, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DividerLine(),
        data,
        const DividerLine(),
        Text('Report Message: $message'),
        const DividerLine(),
      ],
    );
  }
}
