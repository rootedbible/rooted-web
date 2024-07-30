
import "../const.dart";

/// Represents a subscription.
class Subscription {
  /// The unique identifier of the subscription.
  final int id;

  /// Indicates whether the subscription is active.
  final bool isActive;

  /// The ID of the plan associated with the subscription.
  final int? planId;

  /// The maximum number of members allowed in the subscription.
  final int maxMembers;

  /// The type of the subscription.
  final String type;

  /// Indicates whether the subscription has reached its maximum number of members.
  final bool atMax;

  /// The ID of the owner of the subscription.
  final int ownerId;

  /// Constructs an instance of [Subscription].
  ///
  /// [id] is the unique identifier of the subscription.
  ///
  /// [type] is the type of the subscription.
  ///
  /// [maxMembers] is the maximum number of members allowed in the subscription.
  ///
  /// [isActive] indicates whether the subscription is active.
  ///
  /// [planId] is the ID of the plan associated with the subscription.
  ///
  /// [atMax] indicates whether the subscription has reached its maximum number of members.
  ///
  /// [ownerId] is the ID of the owner of the subscription.
  Subscription({
    required this.id,
    required this.type,
    required this.maxMembers,
    required this.isActive,
    required this.planId,
    required this.atMax,
    required this.ownerId,
  });

  /// Constructs an instance of [Subscription] from a JSON object.
  ///
  /// The [json] parameter is a map representing the JSON object.
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"],
      type: json["subscription_type"],
      maxMembers: json["subscription_type"] == coupleType
          ? 2
          : json["max_members"] ?? 1,
      isActive: json["is_active"],
      planId: json["plan_id"],
      atMax: json["at_max_members"] ?? true,
      ownerId: json["user_id"],
    );
  }
}
