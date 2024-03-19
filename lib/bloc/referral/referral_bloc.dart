import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'referral_event.dart';
part 'referral_state.dart';

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  ReferralBloc() : super(ReferralInitial()) {
    on<ReferralEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
