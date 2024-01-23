class RecentRecording {
  final int id;
  final String book;
  final int chapter;
  final double accuracy;

  final String timestamp;

  RecentRecording({
    required this.id,
    required this.chapter,
    required this.book,
    required this.accuracy,
    required this.timestamp,
  });

  factory RecentRecording.fromJson(Map<String, dynamic> json) {
    return RecentRecording(
      id: json['id'],
      chapter: json['chapter'],
      book: json['book'],
      accuracy: json['accuracy'],
      timestamp: json['timestamp'],
    );
  }
}
