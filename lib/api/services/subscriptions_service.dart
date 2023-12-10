import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rooted_web/api/responses/plans_response.dart';
import 'package:rooted_web/utils/pretty_print.dart';

import '../../const.dart';
import '../api.dart';

class SubscriptionsService {
  final Dio dio = Api().dio;
  final String route = 'subscriptions';

  Future<PlansResponse> getPlans() async {
    try {
      final url = '$baseUrl/$route/plans';
      final response = await dio.get(url);
      prettyPrintMap(response.data);
      return PlansResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Error on get me: $e');
      rethrow;
    }
  }
}
