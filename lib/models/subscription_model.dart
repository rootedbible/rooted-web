class Subscription {
  final int id;
  final int userId;
  final String? expiration;
  final bool isActive;
  final bool isCanceled;
  final String? type;

  Subscription({
    required this.id,
    required this.userId,
    required this.expiration,
    required this.isActive,
    required this.isCanceled,
    required this.type,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      isCanceled: json['is_canceled'],
      expiration: json['expiration'],
      isActive: json['is_active'],
      userId: json['user_id'],
      type: json['plan_type'],
    );
  }

  String? get expirationDateAsString {
    final dt = DateTime.tryParse(expiration ?? '');
    if (dt == null) return null;

    return '${dt.month}/${dt.day}/${dt.year}';
  }

  Subscription copyWith({
    int? id,
    int? userId,
    String? expiration,
    bool? isActive,
    bool? isCanceled,
    String? type,
  }) {
    return Subscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      expiration: expiration ?? this.expiration,
      isActive: isActive ?? this.isActive,
      isCanceled: isCanceled ?? this.isCanceled,
      type: type ?? this.type,
    );
  }
}
