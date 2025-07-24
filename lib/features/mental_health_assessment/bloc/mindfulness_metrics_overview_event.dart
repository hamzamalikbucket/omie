part of 'mindfulness_metrics_overview_bloc.dart';

/// [MindfulnessMetricsOverviewEvent] - Base event class for mindfulness metrics overview events
/// Events handle user interactions and data loading for the metrics overview screen
abstract class MindfulnessMetricsOverviewEvent extends Equatable {
  const MindfulnessMetricsOverviewEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMindfulnessMetricsOverview] - Event to load mindfulness metrics overview data
/// Triggered when the page is first loaded
class LoadMindfulnessMetricsOverview extends MindfulnessMetricsOverviewEvent {
  const LoadMindfulnessMetricsOverview();
}

/// [ViewInsightFromOverview] - Event to view detailed insights from overview
/// Triggered when user taps on "View Insight" button
class ViewInsightFromOverview extends MindfulnessMetricsOverviewEvent {
  const ViewInsightFromOverview();
}

/// [ConsultAIAssistantFromOverview] - Event to consult AI assistant from overview
/// Triggered when user taps on "Consult AI Assistant" button
class ConsultAIAssistantFromOverview extends MindfulnessMetricsOverviewEvent {
  const ConsultAIAssistantFromOverview();
}

/// [RefreshOverviewData] - Event to refresh the overview data
/// Triggered when user wants to reload data
class RefreshOverviewData extends MindfulnessMetricsOverviewEvent {
  const RefreshOverviewData();
}
