class Subscription {
  final int id;
  final int userId;
  final String expiration;
  final bool isActive;

  Subscription({
    required this.id,
    required this.expiration,
    required this.isActive,
    required this.userId,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
        id: json['id'],
        expiration: json['expiration'],
        isActive: json['is_active'],
        userId: json['user_id'],);
  }
}
