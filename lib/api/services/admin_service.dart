import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:rooted_web/api/responses/user_stats_response.dart";
import "package:rooted_web/models/admin/user_contact.dart";
import "package:rooted_web/models/admin/user_stat_model.dart";

import "../../const.dart";
import "../../models/admin/referral_model.dart";
import "../../utils/string_to_date.dart";
import "../api.dart";

class AdminService {
  final Dio dio = Api().dio;

  final String route = "admin";

  Future<List<UserContact>> getAllUserContact() async {
    try {
      final url = "$baseUrl/$route/users/emails";
      final response = await dio.get(url);
      final data = response.data as List<dynamic>;
      final List<UserContact> userContacts = [];
      for (final Map<String, dynamic> userContact in data) {
        userContacts.add(UserContact.fromJson(userContact));
      }
      return userContacts;
    } catch (e) {
      debugPrint("ERROR ON TOGGLE USER ROUTE: $e");
      rethrow;
    }
  }

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
      debugPrint("ERROR ON TOGGLE USER ROUTE: $e");
      rethrow;
    }
  }

  Future<List<Referral>> getReferrals() async {
    try {
      final url = "$baseUrl/$route/referrals";
      final response = await dio.get(url);
      final data = response.data as List<dynamic>;
      final List<Referral> referrals = [];
      print(response.data);
      for (final Map<String, dynamic> referral in data) {
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
    required String code,
  }) async {
    try {
      final url = "$baseUrl/$route/referrals";
      final data = {
        "meta": meta,
        "type": "organization",
        "code": code,
        "start_date": convertStringToDate(startTime)?.toIso8601String(),
        "end_date": convertStringToDate(endTime)?.toIso8601String(),
      };

      final formData = FormData.fromMap(data);

      await dio.post(
        url,
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
    } catch (e) {
      debugPrint("Error creating referral: $e");
      rethrow;
    }
  }

  Future<String> statsTotalMinutes() async {
    try {
      final url = "$baseUrl/$route/recordings/total-minutes";
      final response = await dio.get(url);
      return (response.data as double).toStringAsFixed(2);
    } catch (e) {
      debugPrint("Error Getting statsTotalMinutes: $e ");
      rethrow;
    }
  }

  Future<void> statsSubscriptionCounts() async {
    try {
      final url = "$baseUrl/$route/subscriptions/counts";
      await dio.get(url);
    } catch (e) {
      debugPrint("Error Getting statsSubscriptionCounts: $e ");
      rethrow;
    }
  }

  Future<List<UserStat>> statsUsersTotalPerMonth() async {
    try {
      final url = "$baseUrl/$route/users/total-per-month";
      final response = await dio.get(url);
      return UserStatsResponse.fromMap(response.data).userStats;
    } catch (e) {
      debugPrint("Error Getting statsUsersTotalPerMonth: $e ");
      rethrow;
    }
  }
}
