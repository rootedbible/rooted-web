import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rooted_web/api/responses/plans_response.dart';
import 'package:rooted_web/utils/pretty_print.dart';
import 'package:universal_html/html.dart';
import '../../const.dart';
import '../api.dart';

class SubscriptionsService {
  final Dio dio = Api().dio;
  final String route = 'subscriptions';

  Future<PlansResponse> getPlans() async {
    try {
      final url = '$baseUrl/$route/plans';
      final response = await dio.get(url);
      for (Map<String, dynamic> json in response.data as List<dynamic>) {
        prettyPrintMap(json);
      }
      return PlansResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Error on get plans: $e');
      rethrow;
    }
  }

  Future<String> createOrganization({
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
      final url = '$baseUrl/$route/';
      final Map<String, dynamic> org = {
        if (uniqueName != null) 'unique_name': uniqueName,
        if (email != null) 'email': email,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
        if (addressTwo != null) 'address_two': addressTwo,
        if (city != null) 'city': city,
        if (state != null) 'state': state,
        if (zip != null) 'zip': zip,
        if (website != null) 'website': website,
        if (facebook != null) 'facebook': facebook,
        if (instagram != null) 'instagram': instagram,
        if (tiktok != null) 'tiktok': tiktok,
        if (x != null) 'x': x,
        'invite_only': inviteOnly,
      };

      final Map<String, dynamic> data = {
        'price_id': priceId,
        // TODO: Implement discounts
        // "discount_code": "ROOTED20",
        'plan_id': planId,
        'frequency': frequency,
        'success_url': window.location.href,
        if (uniqueName != null) 'organization': org,
      };

      final response = await dio.post(url, data: data);
      if (!response.statusCode!.toString().startsWith('2')) {
        debugPrint(
          'Failed to create organization with status code: ${response.statusCode}',
        );
      }
      return response.data['id'];
    } catch (e) {
      debugPrint('Error on create organization: $e');
      rethrow;
    }
  }
}
