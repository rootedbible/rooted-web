
import "../../models/admin/comment_model.dart";

class CommentsResponse {
  final List<CommentModel> comments;

  CommentsResponse({required this.comments});

  factory CommentsResponse.fromJson(List<dynamic> json) {
    final List<CommentModel> comments = [];
    for (final Map<String, dynamic> comment in json) {
      comments.add(CommentModel.fromJson(comment));
    }
    return CommentsResponse(comments: comments);
  }
}
