class Plan {
  final int id;
  final String type;
  final int maxMembers;
  final double annualCost;
  final double monthlyCost;

  Plan({
    required this.type,
    required this.id,
    required this.annualCost,
    required this.maxMembers,
    required this.monthlyCost,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      type: json['type'],
      id: json['id'],
      annualCost: json['cost_yearly'],
      maxMembers: json['max_members'],
      monthlyCost: json['cost_monthly'],
    );
  }
}
