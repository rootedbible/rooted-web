class Report {
  final int id;
  final int reportingUserId;
  final int reportedEntityId;
  final String comment;
  final String type;
  final bool handled;
  final String createdAt;

  Report({
    required this.comment,
    required this.createdAt,
    required this.id,
    required this.type,
    required this.handled,
    required this.reportedEntityId,
    required this.reportingUserId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      comment: json["comment"],
      createdAt: json["created_at"],
      id: json["id"],
      type: json["type"],
      handled: json["handled"],
      reportedEntityId: json["entity_id"],
      reportingUserId: json["reporting_user_id"],
    );
  }
}
