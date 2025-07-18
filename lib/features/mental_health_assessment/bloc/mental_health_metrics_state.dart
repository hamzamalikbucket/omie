part of 'mental_health_metrics_bloc.dart';

/// [MentalHealthMetricsState] - Base state class for Mental Health Metrics screen
abstract class MentalHealthMetricsState extends Equatable {
  const MentalHealthMetricsState();

  @override
  List<Object> get props => [];
}

/// [MentalHealthMetricsInitial] - Initial state
class MentalHealthMetricsInitial extends MentalHealthMetricsState {
  @override
  List<Object> get props => [];
}

/// [MentalHealthMetricsLoading] - Loading state
class MentalHealthMetricsLoading extends MentalHealthMetricsState {
  @override
  List<Object> get props => [];
}

/// [MentalHealthMetricsLoaded] - Loaded state with metrics data
class MentalHealthMetricsLoaded extends MentalHealthMetricsState {
  final MentalHealthMetricsData metricsData;

  const MentalHealthMetricsLoaded(this.metricsData);

  @override
  List<Object> get props => [metricsData];
}

/// [MentalHealthMetricsError] - Error state
class MentalHealthMetricsError extends MentalHealthMetricsState {
  final String message;

  const MentalHealthMetricsError(this.message);

  @override
  List<Object> get props => [message];
}
