import "package:rooted_web/models/admin/recorded_note.dart";
import "package:rooted_web/models/admin/recorded_verse.dart";
import "package:rooted_web/utils/pretty_print.dart";

class ChapterData {
  final String? book;
  final int? number;
  final int? id;
  final String audioUrl;
  final double duration;
  final bool isOwner;
  final List<RecordedVerse> recordedVerses;
  final List<RecordedNote> recordedNotes;

  ChapterData({
    required this.isOwner,
    required this.id,
    required this.audioUrl,
    required this.recordedVerses,
    required this.recordedNotes,
    required this.number,
    required this.book,
    required this.duration,
  });

  factory ChapterData.fromJson(Map<String, dynamic> json) {
    final List<RecordedVerse> recordedVerses = [];
    final List<RecordedNote> recordedNotes = [];

    for (final Map<String, dynamic> recordedVerse in json["recorded_verses"]) {
      recordedVerses.add(RecordedVerse.fromJson(recordedVerse));
    }
    for (final Map<String, dynamic> recordedNote in json["recorded_notes"]) {
      recordedNotes.add(RecordedNote.fromJson(recordedNote));
    }
    prettyPrintMap(json);
    return ChapterData(
      isOwner: json["is_owner"] ?? true,
      id: json["id"],
      audioUrl: json["audio_url"],
      recordedVerses: recordedVerses,
      recordedNotes: recordedNotes,
      duration: json["duration"] ?? 0.0,
      number: json["number"],
      book: json["book"],
    );
  }

  ChapterData copyWith({
    bool? isOwner,
    int? id,
    String? audioUrl,
    List<RecordedVerse>? recordedVerses,
    List<RecordedNote>? recordedNotes,
    double? duration,
    String? book,
    int? number,
  }) {
    return ChapterData(
        isOwner: isOwner ?? this.isOwner,
        id: id ?? this.id,
        audioUrl: audioUrl ?? this.audioUrl,
        recordedVerses: recordedVerses ?? this.recordedVerses,
        recordedNotes: recordedNotes ?? this.recordedNotes,
        duration: duration ?? this.duration,
        book: book ?? this.book,
        number: number ?? this.number,);
  }
}
