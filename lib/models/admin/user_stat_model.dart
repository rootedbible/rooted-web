class UserStat {
  final int count;
  final int year;
  final int month;

  UserStat({
    required this.year,
    required this.month,
    required this.count,
  });

  factory UserStat.fromJson(Map<String, dynamic> json) {
    return UserStat(
      year: json['year'],
      month: json['month'],
      count: json['count'],
    );
  }
}
