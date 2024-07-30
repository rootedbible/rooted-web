
import "package:bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:rooted_web/api/services/admin_service.dart";

import "../../../models/admin/referral_model.dart";

part "referral_event.dart";

part "referral_state.dart";

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  List<Referral> referrals = [];

  ReferralBloc() : super(ReferralsLoading()) {
    on<GetReferrals>((event, emit) async {
      try {
        emit(ReferralsLoading());
        referrals= await AdminService().getReferrals();
        emit(ReferralsLoaded());
      } catch (e) {
        debugPrint("Error getting referrals: $e");
        emit(ReferralsError(error: e.toString()));
      }
    });
  }
}
