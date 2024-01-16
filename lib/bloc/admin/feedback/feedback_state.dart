part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackLoaded extends FeedbackState {}

class FeedbackError extends FeedbackState {
  final String error;

  FeedbackError({
    required this.error,
  });
}
