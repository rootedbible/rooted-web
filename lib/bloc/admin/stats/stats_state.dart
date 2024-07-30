part of "stats_bloc.dart";

@immutable
sealed class StatsState {}

final class StatsUnloaded extends StatsState {}

final class StatsLoading extends StatsState {}

final class StatsLoaded extends StatsState {}

final class StatsError extends StatsState {
  final String error;

  StatsError({
    required this.error,
  });
}
