part of 'reports_bloc.dart';

@immutable
abstract class ReportsEvent {}

class GetReports extends ReportsEvent {}

class DismissReport extends ReportsEvent {
  final int index;

  DismissReport({required this.index});
}
