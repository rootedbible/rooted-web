class UserStat {
  final int count;
  final String year;
  final int month;

  UserStat({
    required this.year,
    required this.month,
    required this.count,
  });

  factory UserStat.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserStat(
      year: json['year'].toString()[2]+json['year'].toString()[3],
      month: json['month'],
      count: json['count'],
    );
  }
}
