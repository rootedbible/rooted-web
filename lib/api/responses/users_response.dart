import '../../models/user_model.dart';

class UsersResponse {
  final List<User> users;
  final String? message;

  UsersResponse({
    required this.message,
    required this.users,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json, {String? status}) {
    List<User> users = [];
    for (Map<String, dynamic> user in json['users']) {
      users.add(User.fromJson(user, status: status));
    }
    return UsersResponse(message: json['message'], users: users);
  }
}
