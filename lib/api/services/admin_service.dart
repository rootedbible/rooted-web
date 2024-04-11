import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rooted_web/api/responses/user_stats_response.dart';
import 'package:rooted_web/models/admin/user_stat_model.dart';
import 'package:rooted_web/utils/pretty_print.dart';

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

  Future<String> statsTotalMinutes() async {
    try {
      final url = '$baseUrl/$route/recordings/total-minutes';
      final response = await dio.get(url);
      return (response.data as double).toStringAsFixed(2);
    } catch (e) {
      debugPrint('Error Getting statsTotalMinutes: $e ');
      rethrow;
    }
  }

  Future<void> statsSubscriptionCounts() async {
    try {
      final url = '$baseUrl/$route/subscriptions/counts';
      final response = await dio.get(url);
      print(url);
      print(response.data);
      print(prettyPrintMap(response.data));
    } catch (e) {
      debugPrint('Error Getting statsSubscriptionCounts: $e ');
      rethrow;
    }
  }

  Future<List<UserStat>> statsUsersTotalPerMonth() async {
    try {
      final url = '$baseUrl/$route/users/total-per-month';
      final response = await dio.get(url);
      return UserStatsResponse.fromMap(response.data ).userStats;
    } catch (e) {
      debugPrint('Error Getting statsUsersTotalPerMonth: $e ');
      rethrow;
    }
  }
}
