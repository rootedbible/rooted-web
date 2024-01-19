import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../const.dart';
import '../api.dart';

class AdminService {
  final Dio dio = Api().dio;

  final String route = 'admin';

  Future<Response> toggleUserEnabled(
      {required bool enableUser, required int userId,}) async {
    try {
      final url =
          '$baseUrl/$route/users/$userId/${enableUser ? 'enable' : 'disable'}';
      final response = await dio.put(url);
      return response;
    } catch (e) {
      debugPrint('ERROR ON TOGGLE USER ROUTE: $e');
      rethrow;
    }
  }
}
