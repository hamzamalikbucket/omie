part of 'wellness_score_detail_bloc.dart';

abstract class WellnessScoreDetailEvent extends Equatable {
  const WellnessScoreDetailEvent();
  @override
  List<Object> get props => [];
}

/// Event to change the time period for chart data (1d, 1w, 1m, 1y, All Time)
class ChangeTimePeriod extends WellnessScoreDetailEvent {
  final String timePeriod;
  const ChangeTimePeriod(this.timePeriod);

  @override
  List<Object> get props => [timePeriod];
}

/// Event to load wellness score detail data
class LoadWellnessScoreDetail extends WellnessScoreDetailEvent {
  const LoadWellnessScoreDetail();
}

/// Event to refresh wellness score detail data
class RefreshWellnessScoreDetail extends WellnessScoreDetailEvent {
  const RefreshWellnessScoreDetail();
}

/// Event to refresh wellness data
class RefreshWellnessData extends WellnessScoreDetailEvent {
  const RefreshWellnessData();
}
