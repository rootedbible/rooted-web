import "package:bloc/bloc.dart";
import "package:flutter/foundation.dart";
import "package:rooted_web/api/services/admin_service.dart";

import "../../../models/admin/user_stat_model.dart";

part "stats_event.dart";

part "stats_state.dart";

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  String totalMinutes = "";
  List<UserStat> userStats = [];

  StatsBloc() : super(StatsUnloaded()) {
    on<GetStats>((event, emit) async {
      try {
        emit(StatsLoading());
        totalMinutes = await AdminService().statsTotalMinutes();
        userStats = await AdminService().statsUsersTotalPerMonth();
        await AdminService().statsSubscriptionCounts();
        emit(StatsLoaded());
      } catch (e) {
        debugPrint("Error Getting Stats: $e");
        emit(StatsError(error: e.toString()));
      }
    });
  }
}
