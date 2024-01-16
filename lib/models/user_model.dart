import 'package:rooted_web/models/subscription_model.dart';
import 'package:rooted_web/utils/pretty_print.dart';

class User {
  final int uniqueId;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String? phone;
  final String username;
  final String email;
  final bool isPublic;
  final int followersCount;
  final int followingCount;
  final double percentageRecorded;
  final String? followStatus;
  final String? orgStatus;
  final Subscription? subscription;
  final bool isSuperAdmin;

  User({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    required this.email,
    required this.uniqueId,
    required this.isPublic,
    required this.imageUrl,
    required this.followStatus,
    required this.percentageRecorded,
    required this.followersCount,
    required this.followingCount,
    required this.orgStatus,
    required this.subscription,
    required this.isSuperAdmin,
  });

  factory User.fromJson(
    Map<String, dynamic> json, {
    String? status,
    String? followStatus,
  }) {
    prettyPrintMap(json);
    return User(
      lastName: json['last_name'],
      firstName: json['first_name'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      uniqueId: json['id'],
      isPublic: json['is_public'],
      imageUrl: json['image_url'] ?? 'https://i.imgur.com/jNNT4LE.png',
      followStatus: json['follow_status'],
      percentageRecorded: json['percentage_recorded'],
      followersCount: json['total_followers'],
      followingCount: json['total_following'],
      orgStatus: status ?? json['status'],
      isSuperAdmin: json['is_super_user'] ?? false,
      subscription: json['subscription'] != null
          ? Subscription.fromJson(json['subscription'])
          : null,
    );
  }

  static final empty = User(
    firstName: 'Rooted',
    lastName: 'User',
    username: 'rooted.username',
    phone: null,
    email: 'test@email.com',
    uniqueId: 1,
    isPublic: false,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOtHiT73wb8Lqm2PuUfeHBdkn-GFxuCe0AwARhmuPT7A&s',
    followStatus: null,
    percentageRecorded: 0.0,
    followersCount: 0,
    followingCount: 0,
    orgStatus: 'member',
    subscription: null,
    isSuperAdmin: false,
  );

  User copyWith({
    int? uniqueId,
    String? firstName,
    String? lastName,
    String? imageUrl,
    String? phone,
    String? username,
    String? email,
    bool? isPublic,
    String? followStatus,
    double? percentageRecorded,
    int? followersCount,
    int? followingCount,
    String? orgStatus,
    Subscription? subscription,
    bool? isSuperAdmin,
  }) {
    return User(
      uniqueId: uniqueId ?? this.uniqueId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      email: email ?? this.email,
      isPublic: isPublic ?? this.isPublic,
      followStatus: followStatus ?? this.followStatus,
      percentageRecorded: percentageRecorded ?? this.percentageRecorded,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      orgStatus: orgStatus ?? this.orgStatus,
      subscription: subscription ?? this.subscription,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
    );
  }
}
