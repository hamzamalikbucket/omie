part of 'mindfulness_explanation_bloc.dart';

/// [MindfulnessExplanationEvent] - Base event class for mindfulness explanation events
/// Events handle user interactions and data loading for the explanation screen
abstract class MindfulnessExplanationEvent extends Equatable {
  const MindfulnessExplanationEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMindfulnessExplanation] - Event to load initial mindfulness explanation data
/// Triggered when the page is first loaded
class LoadMindfulnessExplanation extends MindfulnessExplanationEvent {
  const LoadMindfulnessExplanation();
}

/// [NavigateToSection] - Event to navigate to different sections
/// Triggered when user taps on "See All" links
class NavigateToSection extends MindfulnessExplanationEvent {
  /// [sectionName] - The section to navigate to
  final String sectionName;

  const NavigateToSection(this.sectionName);

  @override
  List<Object> get props => [sectionName];
}
