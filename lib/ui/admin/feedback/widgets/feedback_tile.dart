import 'package:flutter/material.dart';
import 'package:rooted_web/api/services/comments_service.dart';
import 'package:rooted_web/models/admin/comment_model.dart';
import 'package:rooted_web/ui/widgets/snackbar.dart';

class FeedbackTile extends StatefulWidget {
  final CommentModel commentModel;

  const FeedbackTile({required this.commentModel, super.key});

  @override
  State<FeedbackTile> createState() => _FeedbackTileState();
}

class _FeedbackTileState extends State<FeedbackTile> {
  late CommentModel commentModel;
  bool archived = false;

  @override
  void initState() {
    super.initState();
    commentModel = widget.commentModel;
  }

  IconData _getReasonIcon() {
    switch (commentModel.reason) {
      case 'bug':
        return Icons.bug_report;
      case 'suggestion':
        return Icons.lightbulb;
      case 'comment':
        return Icons.comment;
      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return archived
        ? const SizedBox.shrink()
        : ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(_getReasonIcon()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    commentModel.platform.toLowerCase().contains('ios')
                        ? Icons.apple
                        : Icons.android,
                  ),
                ),
              ],
            ),
            title: Text(commentModel.comment),
            trailing: IconButton(
              tooltip: 'Archive Comment',
              icon: const Icon(Icons.archive),
              onPressed: () async {
                try {
                  await CommentsService()
                      .archiveComment(commentId: commentModel.id);
                  setState(() {
                    archived = true;
                  });
                  snackbar(context, 'Archived!');
                } catch (e) {
                  snackbar(context, 'Error Archiving: $e');
                }
              },
            ),
          );
  }
}
