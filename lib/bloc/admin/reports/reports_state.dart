part of 'reports_bloc.dart';

@immutable
abstract class ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {}

class ReportsError extends ReportsState {
  final String error;

  ReportsError(this.error);
}
