import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:rooted_web/api/responses/reports_response.dart";

import "../../const.dart";
import "../api.dart";

class ReportsService {
  final Dio dio = Api().dio;
  final String route = "reports";

  Future<ReportsResponse> getReports() async {
    try {
      final url = "$baseUrl/$route";
      final response = await dio.get(url);
      return ReportsResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error Getting Reports!\n$e");
      rethrow;
    }
  }
}
