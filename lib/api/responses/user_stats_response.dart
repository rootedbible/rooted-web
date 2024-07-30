import "../../models/admin/user_stat_model.dart";

class UserStatsResponse {
  final List<UserStat> userStats;

  UserStatsResponse({required this.userStats});

  factory UserStatsResponse.fromMap(List<dynamic> json) {
    final List<UserStat> userStats = [];
    for (final Map<String, dynamic> stat in json) {
      userStats.add(UserStat.fromJson(stat));
    }
    return UserStatsResponse(userStats: userStats);
  }
}
