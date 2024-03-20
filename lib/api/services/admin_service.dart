import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../const.dart';
import '../../models/admin/referral_model.dart';
import '../../utils/string_to_date.dart';
import '../api.dart';

class AdminService {
  final Dio dio = Api().dio;

  final String route = 'admin';

  Future<Response> toggleUserEnabled({
    required bool enableUser,
    required int userId,
  }) async {
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

  Future<List<Referral>> getReferrals() async {
    try {
      final url = '$baseUrl/$route/referrals';
      final response = await dio.get(url);
      final data = response.data as List<dynamic>;
      List<Referral> referrals = [];
      for (Map<String, dynamic> referral in data) {
        referrals.add(Referral.fromJson(referral));
      }
      return referrals;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> createReferral({
    required String meta,
    required String? startTime,
    required String? endTime,
  }) async {
    try {
      final url = '$baseUrl/$route/referrals';
      final data = {
        'meta': meta,
        'type': 'organization',
        if (startTime != null) 'start_date': convertStringToDate(startTime),
        if (endTime != null) 'end_date': convertStringToDate(endTime),
      };
      await dio.post(url, data: data);
    } catch (e) {
      debugPrint('Error creating referral: $e');
      rethrow;
    }
  }
}
