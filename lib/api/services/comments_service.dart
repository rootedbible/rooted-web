import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";

import "../../const.dart";
import "../api.dart";
import "../responses/comments_response.dart";

class CommentsService {
  final Dio dio = Api().dio;
  final String route = "comments";

  Future<CommentsResponse> getComments() async {
    // TODO: Add pagination
    try {
      final url = "$baseUrl/$route";
      final response = await dio.get(url);
      debugPrint("Comments Data:");
      return CommentsResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error getting comments: $e");
      rethrow;
    }
  }

  Future<Response> archiveComment({required int commentId}) async {
    try {
      final url = "$baseUrl/$route/$commentId/archive";
      final response = await dio.put(url);
      return response;
    } catch (e) {
      debugPrint("Error Archiving Comment: $e");
      rethrow;
    }
  }
}
