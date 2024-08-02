class UserContact {
  final String email;
  final String? phone;
  final String username;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final bool activeSubscription;

  UserContact({
    required this.email,
    required this.phone,
    required this.username,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.activeSubscription,
  });

  factory UserContact.fromJson(Map<String, dynamic> json) {
    return UserContact(
      email: json["email"],
      phone: json["phone"],
      createdAt: DateTime.parse(json["created_at"]),
      username: json["username"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      activeSubscription: json["active_subscription"],
    );
  }
}