part of 'reports_bloc.dart';

@immutable
abstract class ReportsEvent {}

class GetReports extends ReportsEvent {
  final String type;
  final bool dismissed;

  GetReports({required this.type, this.dismissed = false});
}

class DismissReport extends ReportsEvent {
  final int index;

  DismissReport({required this.index});
}
