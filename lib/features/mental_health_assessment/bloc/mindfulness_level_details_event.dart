part of 'mindfulness_level_details_bloc.dart';

/// [MindfulnessLevelDetailsEvent] - Base event class for mindfulness level details events
/// Events handle user interactions and data loading for the details screen
abstract class MindfulnessLevelDetailsEvent extends Equatable {
  const MindfulnessLevelDetailsEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMindfulnessLevelDetails] - Event to load mindfulness level details data
/// Triggered when the page is first loaded
class LoadMindfulnessLevelDetails extends MindfulnessLevelDetailsEvent {
  const LoadMindfulnessLevelDetails();
}

/// [ViewInsight] - Event to view detailed insights
/// Triggered when user taps on "View Insight" button
class ViewInsight extends MindfulnessLevelDetailsEvent {
  const ViewInsight();
}

/// [ConsultAIAssistant] - Event to consult AI assistant
/// Triggered when user taps on "Consult AI Assistant" button
class ConsultAIAssistant extends MindfulnessLevelDetailsEvent {
  const ConsultAIAssistant();
}

/// [RefreshDetails] - Event to refresh the details data
/// Triggered when user wants to reload data
class RefreshDetails extends MindfulnessLevelDetailsEvent {
  const RefreshDetails();
}
