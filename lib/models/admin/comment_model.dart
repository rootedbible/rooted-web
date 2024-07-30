class CommentModel {
  final int userId;
  final String reason;
  final String comment;
  final String platform;
  final int id;
  final String createdAt;
  final bool isArchived;

  CommentModel({
    required this.id,
    required this.reason,
    required this.comment,
    required this.userId,
    required this.createdAt,
    required this.isArchived,
    required this.platform,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      reason: json["reason"],
      comment: json["comment"],
      userId: json["user_id"],
      createdAt: json["created_at"],
      isArchived: json["is_archived"],
      platform: json["platform"],
    );
  }
}
