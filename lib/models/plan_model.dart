import 'package:rooted_web/const.dart';

class Plan {
  final int id;
  final String type;
  final int maxMembers;
  final String displayName;
  final double monthlyPrice;
  final double annualPrice;
  final String stripeMonthly;
  final String stripeAnnual;

  Plan({
    required this.type,
    required this.id,
    required this.displayName,
    required this.annualPrice,
    required this.maxMembers,
    required this.monthlyPrice,
    required this.stripeAnnual,
    required this.stripeMonthly,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      type: json['type'],
      id: json['id'],
      displayName: json['display_name'],
      annualPrice: json['annual_price'],
      maxMembers: json['max_members'],
      monthlyPrice: json['monthly_price'],
      stripeAnnual: json['price_id_annual'],
      stripeMonthly: json['price_id_monthly'],
    );
  }

  static final empty = Plan(
    type: familyType,
    id: 0,
    displayName: 'displayName',
    annualPrice: 0,
    maxMembers: 1,
    monthlyPrice: 0,
    stripeAnnual: 'stripeAnnual',
    stripeMonthly: 'stripeMonthly',
  );
}
