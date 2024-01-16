import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/const.dart';
import 'package:rooted_web/ui/admin/feedback/widgets/feedback_tile.dart';

import '../../../bloc/admin/feedback/feedback_bloc.dart';
import '../../../models/admin/comment_model.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedbackBloc>().add(GetFeedback());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(doublePadding),
                child: Text(
                  'Feedback',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<FeedbackBloc>().comments.length,
                  itemBuilder: (context, index) {
                    final CommentModel comment =
                        context.read<FeedbackBloc>().comments[index];
                    return FeedbackTile(commentModel: comment);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
