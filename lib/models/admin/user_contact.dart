class UserContact {
  final String email;
  final String? phone;
  final String username;
  final DateTime createdAt;

  UserContact({
    required this.email,
    required this.phone,
    required this.username,
    required this.createdAt,
  });

  factory UserContact.fromJson(Map<String, dynamic> json) {
    return UserContact(
      email: json["email"],
      phone: json["phone"],
      createdAt: DateTime.parse(json["created_at"]),
      username: json["username"],
    );
  }
}