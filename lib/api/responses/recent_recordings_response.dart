import '../../models/admin/recent_recording_model.dart';

class RecentRecordingsResponse {
  final List<RecentRecording> recentRecordings;

  RecentRecordingsResponse({required this.recentRecordings});

  factory RecentRecordingsResponse.fromJson(List<dynamic> recs) {
    List<RecentRecording> recentRecordings = [];
    for (Map<String, dynamic> recentRecording in recs) {
      recentRecordings.add(RecentRecording.fromJson(recentRecording));
    }
    return RecentRecordingsResponse(recentRecordings: recentRecordings);
  }
}
