class RecordedNote {
  final double location;
  final String url;

  RecordedNote({
    required this.url,
    required this.location,
  });

  factory RecordedNote.fromJson(Map<String, dynamic> json) {
    return RecordedNote(
      url: json['audio_url'],
      location: json['location'],
    );
  }

  RecordedNote copyWith({
    double? location,
    String? url,
  }) {
    return RecordedNote(
      location: location ?? this.location,
      url: url ?? this.url,
    );
  }
}
