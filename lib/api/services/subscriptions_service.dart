import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:rooted_web/api/responses/plans_response.dart";
import "package:universal_html/html.dart";
import "../../const.dart";
import "../api.dart";

class SubscriptionsService {
  final Dio dio = Api().dio;
  final String route = "subscriptions";

  Future<PlansResponse> getPlans() async {
    try {
      final url = "$baseUrl/$route/plans";
      final response = await dio.get(url);
      return PlansResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error on get plans: $e");
      rethrow;
    }
  }

  Future<String> createSubscription(
    String type, {
    required String priceId,
    required int planId,
    required String frequency,
    required String? uniqueName,
    required String? email,
    required String? name,
    required String? description,
    required String? phone,
    required String? address,
    required String? addressTwo,
    required String? city,
    required String? state,
    required String? zip,
    required String? website,
    required String? facebook,
    required String? instagram,
    required String? tiktok,
    required String? x,
    required bool inviteOnly,
  }) async {
    try {
      final url = "$baseUrl/$route/purchase";
      final Map<String, dynamic> org = {
        if (uniqueName != null) "unique_name": uniqueName,
        if (email != null) "email": email,
        if (name != null) "name": name,
        if (description != null) "description": description,
        if (phone != null) "phone": phone,
        if (address != null) "address": address,
        if (addressTwo != null) "address_two": addressTwo,
        if (city != null) "city": city,
        if (state != null) "state": state,
        if (zip != null) "zip": zip,
        if (website != null) "website": website,
        if (facebook != null) "facebook": facebook,
        if (instagram != null) "instagram": instagram,
        if (tiktok != null) "tiktok": tiktok,
        if (x != null) "x": x,
        "invite_only": inviteOnly,
      };

      final Map<String, dynamic> data = {
        "price_id": priceId,
        "plan_id": planId,
        "frequency": frequency,
        "success_url": window.location.href,
        if (type != individualType) "organization": org,
      };

      final response = await dio.post(url, data: data);

      return response.data["stripe_url"];
    } on DioException catch (dioError) {
      debugPrint("DioError caught: ${dioError.message}");
      if (dioError.response != null) {
        debugPrint("Status code: ${dioError.response?.statusCode}");
        debugPrint("Data: ${dioError.response?.data}");
        throw dioError.response!.data["detail"][0]["msg"] ?? "Dio Error";
      }
      rethrow;
    } catch (e) {
      debugPrint("Error on create organization: $e");
      rethrow;
    }
  }

  Future<Response> cancel(int id) async {
    try {
      final url = "$baseUrl/$route/cancel/$id";

      final response = await dio.post(url);

      return response;
    } on DioException catch (dioError) {
      debugPrint("DioError caught: ${dioError.message}");
      if (dioError.response != null) {
        debugPrint("Status code: ${dioError.response?.statusCode}");
        debugPrint("Data: ${dioError.response?.data}");
      }
      rethrow;
    } catch (e) {
      debugPrint("Error on cancel subscription: $e");
      rethrow;
    }
  }

  Future<String> renewSubscription({required int subscriptionId}) async {
    try {
      final url = "$baseUrl/$route/renew/$subscriptionId";
      final Map<String, dynamic> data = {
        "success_url": window.location.href,
      };
      final response = await dio.post(url, data: data);
      return response.data["stripe_url"];
    } on DioException catch (dioError) {
      debugPrint("DioError caught: ${dioError.message}");
      if (dioError.response != null) {
        debugPrint("Status code: ${dioError.response?.statusCode}");
        debugPrint("Data: ${dioError.response?.data}");
        debugPrint("Headers: ${dioError.response?.headers}");
      }
      rethrow;
    } catch (e) {
      debugPrint("Error on renew subscription: $e");
      rethrow;
    }
  }
}
