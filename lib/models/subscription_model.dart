class Subscription {
  final int id;
  final int userId;
  final String expiration;
  final bool isActive;
  final bool isCanceled;

  Subscription({
    required this.id,
    required this.userId,
    required this.expiration,
    required this.isActive,
    required this.isCanceled,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      isCanceled: json['is_canceled'],
      expiration: json['expiration'],
      isActive: json['is_active'],
      userId: json['user_id'],
    );
  }

  Subscription copyWith({
    int? id,
    int? userId,
    String? expiration,
    bool? isActive,
    bool? isCanceled,
  }) {
    return Subscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      expiration: expiration ?? this.expiration,
      isActive: isActive ?? this.isActive,
      isCanceled: isCanceled ?? this.isCanceled,
    );
  }
}
