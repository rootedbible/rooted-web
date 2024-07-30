
import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:rooted_web/api/services/comments_service.dart";

import "../../../models/admin/comment_model.dart";

part "feedback_event.dart";

part "feedback_state.dart";

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {

  List<CommentModel> comments = [];

  FeedbackBloc() : super(FeedbackLoading()) {
    on<GetFeedback>((event, emit) async {
      try {
        emit(FeedbackLoading());
        comments = (await CommentsService().getComments()).comments;
        emit(FeedbackLoaded());
      } catch (e) {
        debugPrint("Error getting feedback");
        emit(FeedbackError(error: e.toString()));
      }
    });
  }
}
