const String referralUserType = "user";
const String referralOrgType = "organization";

class Referral {
  final int id;
  final String meta;
  final String code;
  final String type;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final int totalUsers;
  final double totalRevenue;

  Referral({
    required this.id,
    required this.meta,
    required this.code,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.totalUsers,
    required this.totalRevenue,
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json["id"],
      meta: json["meta"],
      code: json["code"],
      type: json['type'] == 'org' ? referralOrgType: json["type"],
      endDate:
          json["end_date"] != null ? DateTime.parse(json["end_date"]) : null,
      startDate: json["start_date"] != null
          ? DateTime.parse(json["start_date"])
          : null,
      createdAt: DateTime.parse(json["created_at"]),
      totalUsers: json["total_users"],
      totalRevenue: json["total_revenue"],
    );
  }
}
