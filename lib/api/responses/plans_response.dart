import "package:rooted_web/utils/pretty_print.dart";

import "../../../models/plan_model.dart";

class PlansResponse {
  final List<Plan> plans;

  PlansResponse({required this.plans});

  factory PlansResponse.fromJson(List<dynamic> recs) {
    final List<Plan> plans = [];
    for (final Map<String, dynamic> plan in recs) {
      prettyPrintMap(plan);
      plans.add(Plan.fromJson(plan));
    }
    return PlansResponse(plans: plans);
  }
}
