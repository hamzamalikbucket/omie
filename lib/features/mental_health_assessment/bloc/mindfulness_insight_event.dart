part of 'mindfulness_insight_bloc.dart';

/// [MindfulnessInsightEvent] - Base event class for mindfulness insight events
/// Events handle user interactions and data loading for the insight screen
abstract class MindfulnessInsightEvent extends Equatable {
  const MindfulnessInsightEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMindfulnessInsight] - Event to load mindfulness insight data
/// Triggered when the page is first loaded
class LoadMindfulnessInsight extends MindfulnessInsightEvent {
  const LoadMindfulnessInsight();
}

/// [ChangeDateFilter] - Event to change the date filter
/// Triggered when user selects a different time period
class ChangeDateFilter extends MindfulnessInsightEvent {
  final String dateFilter;

  const ChangeDateFilter(this.dateFilter);

  @override
  List<Object> get props => [dateFilter];
}

/// [ViewTrendDetails] - Event to view trend details
/// Triggered when user taps on "See All" in trend section
class ViewTrendDetails extends MindfulnessInsightEvent {
  const ViewTrendDetails();
}

/// [ViewMomentDetails] - Event to view mindful moment details
/// Triggered when user taps on "See All" in moment section
class ViewMomentDetails extends MindfulnessInsightEvent {
  const ViewMomentDetails();
}

/// [RefreshInsightData] - Event to refresh the insight data
/// Triggered when user wants to reload data
class RefreshInsightData extends MindfulnessInsightEvent {
  const RefreshInsightData();
}
