import '../../../models/plan_model.dart';

class PlansResponse {
  final List<Plan> plans;

  PlansResponse({required this.plans});

  factory PlansResponse.fromJson(List<dynamic> recs) {
    List<Plan> plans = [];
    for (Map<String, dynamic> plan in recs) {
      plans.add(Plan.fromJson(plan));
    }
    return PlansResponse(plans: plans);
  }
}
