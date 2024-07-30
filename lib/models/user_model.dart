import "package:rooted_web/models/subscription_model.dart";

import "../utils/pretty_print.dart";

/// Represents a user.
class User {
  final bool enabled;
  final bool isSuperAdmin;

  /// Indicates whether the user receives post notifications.
  final bool postNotifications;

  /// The unique identifier of the user.
  final int uniqueId;

  /// The first name of the user.
  final String firstName;

  /// The last name of the user.
  final String lastName;

  /// The URL of the user's profile picture.
  final String imageUrl;

  /// The phone number of the user.
  final String? phone;

  /// The username of the user.
  final String username;

  /// The email address of the user.
  final String email;

  /// Indicates whether the user's profile is public.
  final bool isPublic;

  /// The number of followers the user has.
  final int followersCount;

  /// The number of users the user is following.
  final int followingCount;

  /// The percentage of recording completed by the user.
  final double percentageRecorded;

  /// The status of the user's following relationship.
  final String? followingStatus;

  /// The status of the user's follower relationship.
  final String? followerStatus;

  /// The status of the user's organization membership.
  final String? orgStatus;

  /// Indicates whether the user has an active subscription.
  final bool hasActiveSubscription;

  /// The recording streak of the user.
  final int recordingStreak;

  /// The subscription details of the user.
  final Subscription? subscription;

  /// Constructs an instance of [User].
  ///
  /// [firstName] is the first name of the user.
  ///
  /// [lastName] is the last name of the user.
  ///
  /// [username] is the username of the user.
  ///
  /// [phone] is the phone number of the user.
  ///
  /// [email] is the email address of the user.
  ///
  /// [uniqueId] is the unique identifier of the user.
  ///
  /// [isPublic] indicates whether the user's profile is public.
  ///
  /// [imageUrl] is the URL of the user's profile picture.
  ///
  /// [followingStatus] is the status of the user's following relationship.
  ///
  /// [percentageRecorded] is the percentage of recording completed by the user.
  ///
  /// [followersCount] is the number of followers the user has.
  ///
  /// [followingCount] is the number of users the user is following.
  ///
  /// [orgStatus] is the status of the user's organization membership.
  ///
  /// [followerStatus] is the status of the user's follower relationship.
  ///
  /// [hasActiveSubscription] indicates whether the user has an active subscription.
  ///
  /// [recordingStreak] is the recording streak of the user.
  ///
  /// [postNotifications] indicates whether the user receives post notifications.
  ///
  /// [subscription] is the subscription details of the user.
  User({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    required this.email,
    required this.uniqueId,
    required this.isPublic,
    required this.imageUrl,
    required this.enabled,
    required this.followingStatus,
    required this.percentageRecorded,
    required this.followersCount,
    required this.followingCount,
    required this.orgStatus,
    required this.followerStatus,
    required this.hasActiveSubscription,
    required this.recordingStreak,
    required this.postNotifications,
    required this.subscription,
    required this.isSuperAdmin,
  });

  /// Constructs an instance of [User] from a JSON object.
  ///
  /// The [json] parameter is a map representing the JSON object.
  factory User.fromJson(
    Map<String, dynamic> json, {
    String? status,
  }) {
    prettyPrintMap(json);
    return User(
      isSuperAdmin: json["is_super_user"] ?? false,
      enabled: json["is_active"] ?? true,
      hasActiveSubscription: json["has_active_subscription"] ?? false,
      lastName: json["last_name"],
      firstName: json["first_name"],
      username: json["username"].toString().toLowerCase(),
      phone: json["phone"],
      email: json["email"],
      uniqueId: json["id"],
      isPublic: json["is_public"] ?? false,
      imageUrl: json["image_url"] ?? "https://i.imgur.com/jNNT4LE.png",
      followingStatus: json["following_status"],
      followerStatus: json["follower_status"],
      percentageRecorded: json["percentage_recorded"],
      followersCount: json["total_followers"],
      followingCount: json["total_following"],
      orgStatus: status ?? json["status"],
      recordingStreak: json["current_streak"] ?? 0,
      postNotifications: json["receive_alerts"] ?? false,
      subscription: json["subscription"] != null
          ? Subscription.fromJson(json["subscription"])
          : null,
    );
  }

  /// An empty instance of [User].
  static final empty = User(
    enabled: true,
    isSuperAdmin: false,
    postNotifications: false,
    hasActiveSubscription: false,
    firstName: "Rooted",
    lastName: "User",
    username: "rooted.username",
    phone: null,
    email: "test@email.com",
    uniqueId: 1,
    isPublic: false,
    imageUrl: "https://i.imgur.com/jNNT4LE.png",
    followingStatus: null,
    followerStatus: null,
    percentageRecorded: 0.0,
    followersCount: 0,
    followingCount: 0,
    orgStatus: "member",
    recordingStreak: 0,
    subscription: null,
  );

  /// Creates a copy of this [User] but with the given fields replaced with the new values.
  ///
  /// [uniqueId], [firstName], [lastName], [imageUrl], [phone], [username], [email], [isPublic],
  /// [followingStatus], [followerStatus], [percentageRecorded], [followersCount], [followingCount],
  /// [orgStatus], [hasActiveSubscription], [recordingStreak], [postNotifications], and [subscription]
  /// are optional parameters.
  User copyWith({
    int? uniqueId,
    String? firstName,
    String? lastName,
    String? imageUrl,
    String? phone,
    String? username,
    String? email,
    bool? isPublic,
    String? followingStatus,
    String? followerStatus,
    double? percentageRecorded,
    int? followersCount,
    int? followingCount,
    String? orgStatus,
    bool? hasActiveSubscription,
    int? recordingStreak,
    bool? postNotifications,
    Subscription? subscription,
    bool? enabled,
    bool? isSuperAdmin,
  }) {
    return User(
      enabled: enabled ?? this.enabled,
      postNotifications: postNotifications ?? this.postNotifications,
      hasActiveSubscription:
          hasActiveSubscription ?? this.hasActiveSubscription,
      uniqueId: uniqueId ?? this.uniqueId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      email: email ?? this.email,
      isPublic: isPublic ?? this.isPublic,
      followingStatus: followingStatus ?? this.followingStatus,
      followerStatus: followerStatus ?? this.followerStatus,
      percentageRecorded: percentageRecorded ?? this.percentageRecorded,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      orgStatus: orgStatus ?? this.orgStatus,
      recordingStreak: recordingStreak ?? this.recordingStreak,
      subscription: subscription ?? this.subscription,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
    );
  }
}
