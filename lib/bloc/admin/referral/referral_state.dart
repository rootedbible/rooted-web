part of 'referral_bloc.dart';

@immutable
abstract class ReferralState {}

class ReferralsLoading extends ReferralState {}
class ReferralsLoaded extends ReferralState {}
class ReferralsError extends ReferralState {
  final String error;
  ReferralsError({required this.error});
}
