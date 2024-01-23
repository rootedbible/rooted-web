import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../const.dart';
import '../api.dart';
import '../responses/chapter_data_response.dart';
import '../responses/recent_recordings_response.dart';

class RecordingsService {
  final Dio dio = Api().dio;
  final String route = 'recordings';

  Future<RecentRecordingsResponse> getRecentChapters(int userId) async {
    try {
      final url = '$baseUrl/$route/user/$userId/recent-chapters';
      final response = await dio.get(
        url,
      );
      return RecentRecordingsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ChapterDataResponse?> getChapterByInfo({
    required String book,
    required int chapter,
  }) async {
    try {
      final url = '$baseUrl/$route/me/books/$book/chapters/$chapter';
      final response = await dio.get(
        url,
      );
      return ChapterDataResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Error getting chapter data: $e');
      return null;
    }
  }

  Future<ChapterDataResponse> getChapterData(int uniqueId) async {
    try {
      final url = '$baseUrl/$route/chapter/$uniqueId';
      final response = await dio.get(
        url,
      );
      return ChapterDataResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
