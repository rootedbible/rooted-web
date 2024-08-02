import "dart:typed_data";

import "package:flutter/cupertino.dart";
import "package:flutter_excel/excel.dart";
import "package:intl/intl.dart";
import "package:rooted_web/api/services/admin_service.dart";
import "package:universal_html/html.dart" as html;

class UserDownloadService {
  static Future<void> downloadAllUsers() async {
    try {
      final users = await AdminService().getAllUserContact();
      users.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      final excel = Excel.createExcel();
      final Sheet sheetObject = excel["Sheet1"];
      final List<String> headers = [
        "Created",
        "Email",
        "Phone",
        "Username",
        "First Name",
        "Last Name",
        "Active Subscription",
      ];
      sheetObject.appendRow(headers);
      for (final user in users) {
        final List<String> row = [
          DateFormat("MM/dd/yyyy").format(user.createdAt),
          user.email,
          _formatPhone(phone: user.phone),
          user.username,
          user.firstName,
          user.lastName,
          user.activeSubscription ? "Yes" : "No",
        ];
        sheetObject.appendRow(row);
      }
      final fileBytes = Uint8List.fromList(excel.encode()!);
      final String fileName =
          'Rooted Users List - ${DateFormat("MM-dd-yyyy").format(DateTime.now())}.xlsx';
      final blob = html.Blob([fileBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      debugPrint("Error on download all users: $e");
    }
  }

  static String _formatPhone({required String? phone}) {
    if (phone == null) return "";
    if (phone.length == 10 && int.tryParse(phone) != null) {
      return "(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}";
    }
    return phone;
  }
}
