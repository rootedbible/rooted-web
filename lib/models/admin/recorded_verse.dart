class RecordedVerse {
  final double number;
  double startTime;
  double endTime;

  RecordedVerse({
    required this.number,
    required this.startTime,
    required this.endTime,
  });

  factory RecordedVerse.fromJson(Map<String, dynamic> json) {
    return RecordedVerse(
      number: json["verse_number"].toDouble(),
      startTime: json["start_time"],
      endTime: json["end_time"],
    );
  }

  RecordedVerse copyWith({
    double? number,
    double? startTime,
    double? endTime,
  }) {
    return RecordedVerse(
      number: number ?? this.number,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
