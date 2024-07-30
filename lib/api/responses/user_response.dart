import "../../models/user_model.dart";

class UserResponse {
  final User user;
  final String accessToken;

  UserResponse({
    required this.user,
    required this.accessToken,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: User.fromJson(json["user"]),
      accessToken: json["access_token"],
    );
  }
}
