import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rooted_web/utils/pretty_print.dart';

import '../../const.dart';
import '../api.dart';

class ReportsService {
  final Dio dio = Api().dio;
  final String route = 'reports';

  Future<Response> getReports() async {
    try {
      final url = '$baseUrl/$route';
      final response = await dio.get(url);
      debugPrint('Reports Data:');
      prettyPrintMap(response.data);
      return response;
    } catch (e) {
      debugPrint('Error Getting Reports!\n$e');
      rethrow;
    }
  }
}
