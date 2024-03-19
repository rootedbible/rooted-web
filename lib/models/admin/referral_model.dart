/// A class representing a referral.
class Referral {
  /// The unique identifier of the referral.
  final int id;

  /// The name of the referral.
  final String name;

  /// The generated revenue associated with the referral.
  final int generatedRevenue;

  /// The total number of users referred by this referral.
  final int totalUsers;

  /// The date and time when the referral was created.
  final String createdAt;

  /// Constructs a new [Referral] instance.
  ///
  /// All parameters are required.
  Referral({
    required this.id,
    required this.name,
    required this.generatedRevenue,
    required this.totalUsers,
    required this.createdAt,
  });

  /// Creates a [Referral] instance from a JSON map.
  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      generatedRevenue: json['generated_revenue'] ?? 0,
      totalUsers: json['total_users'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }

  /// Creates a copy of this [Referral] instance with the given fields updated.
  ///
  /// If any of the parameters are not provided, the corresponding field will
  /// remain unchanged in the copied instance.
  Referral copyWith({
    int? id,
    String? name,
    int? generatedRevenue,
    int? totalUsers,
    String? createdAt,
  }) {
    return Referral(
      id: id ?? this.id,
      name: name ?? this.name,
      generatedRevenue: generatedRevenue ?? this.generatedRevenue,
      totalUsers: totalUsers ?? this.totalUsers,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
