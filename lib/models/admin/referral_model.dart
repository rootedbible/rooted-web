import 'package:rooted_web/utils/pretty_print.dart';

/// A class representing a referral.
class Referral {
  /// The unique identifier of the referral.
  final int id;

  /// The name of the referral.
  final String name;

  /// The generated revenue associated with the referral.
  final double generatedRevenue;

  /// The total number of users referred by this referral.
  final int totalUsers;

  /// The date and time when the referral was created.
  final String createdAt;

  /// Code for them to use
  final String code;

  /// Constructs a new [Referral] instance.
  ///
  /// All parameters are required.
  Referral({
    required this.id,
    required this.name,
    required this.generatedRevenue,
    required this.totalUsers,
    required this.createdAt,
    required this.code,
  });

  /// Creates a [Referral] instance from a JSON map.
  factory Referral.fromJson(Map<String, dynamic> json) {
    prettyPrintMap(json);
    return Referral(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      generatedRevenue: json['generated_revenue'] ?? 0,
      totalUsers: json['total_users'] ?? 0,
      createdAt: json['created_at'] ?? '',
      code: json['code'] ?? 'ERROR!',
    );
  }

  /// Creates a copy of this [Referral] instance with the given fields updated.
  ///
  /// If any of the parameters are not provided, the corresponding field will
  /// remain unchanged in the copied instance.
  Referral copyWith({
    int? id,
    String? name,
    double? generatedRevenue,
    int? totalUsers,
    String? createdAt,
    String? code,
  }) {
    return Referral(
      id: id ?? this.id,
      name: name ?? this.name,
      generatedRevenue: generatedRevenue ?? this.generatedRevenue,
      totalUsers: totalUsers ?? this.totalUsers,
      createdAt: createdAt ?? this.createdAt,
      code: code ?? this.code,
    );
  }
}
