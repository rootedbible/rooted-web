class Subscription {
  final int id;
  final int userId;
  final String expiration;
  final bool isActive;
  final bool isCanceled;

  Subscription({
    required this.id,
    required this.expiration,
    required this.isActive,
    required this.userId,
    required this.isCanceled,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      isCanceled: json['is_canceled'] ?? false,
      expiration: json['expiration'],
      isActive: json['is_active'],
      userId: json['user_id'],
    );
  }
}
