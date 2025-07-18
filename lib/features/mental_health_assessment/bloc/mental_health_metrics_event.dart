part of 'mental_health_metrics_bloc.dart';

/// [MentalHealthMetricsEvent] - Base event class for Mental Health Metrics screen
abstract class MentalHealthMetricsEvent extends Equatable {
  const MentalHealthMetricsEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMentalHealthMetrics] - Event to load mental health metrics data
class LoadMentalHealthMetrics extends MentalHealthMetricsEvent {
  const LoadMentalHealthMetrics();

  @override
  List<Object> get props => [];
}

/// [UpdateFilter] - Event to update the filter selection
class UpdateFilter extends MentalHealthMetricsEvent {
  final String filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];
}
