import '../../models/admin/chapter_data.dart';

class ChapterDataResponse {
  final ChapterData chapterData;

  ChapterDataResponse({required this.chapterData});

  factory ChapterDataResponse.fromJson(Map<String, dynamic> json) {
    return ChapterDataResponse(chapterData: ChapterData.fromJson(json));
  }
}
