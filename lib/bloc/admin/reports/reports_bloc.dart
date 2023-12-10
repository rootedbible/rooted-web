import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  int page = 0;
  String previousType = '';
  List<dynamic> reports = [];

  ReportsBloc() : super(ReportsLoading()) {
    on<GetReports>((event, emit) async {
      try {
        if (previousType != event.type) {
          emit(ReportsLoading());
          page = 0;
          reports = [];
        }
        // TODO: Get Reports
        reports.addAll([]);
        page++;
        previousType = event.type;
        emit(ReportsLoaded());
      } catch (e) {
        emit(ReportsError(e.toString()));
      }
    });

    on<DismissReport>((event, emit) async {
      try {
        // TODO: Dismiss Report
        reports.removeAt(event.index);
        emit(ReportsLoaded());
      } catch (e) {
        emit(ReportsError(e.toString()));
      }
    });
  }
}
