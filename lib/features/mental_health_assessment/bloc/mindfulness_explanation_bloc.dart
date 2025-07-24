import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mindfulness_explanation_event.dart';
part 'mindfulness_explanation_state.dart';

/// [MindfulnessExplanationBloc] - Business logic component for mindfulness explanation screen
/// Manages state changes, data loading, and user interactions for the educational screen
/// Following Apple's Human Interface Guidelines for smooth state transitions and user feedback
class MindfulnessExplanationBloc
    extends Bloc<MindfulnessExplanationEvent, MindfulnessExplanationState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  MindfulnessExplanationBloc() : super(const MindfulnessExplanationState()) {
    // Register event handlers for different user actions
    on<LoadMindfulnessExplanation>(_onLoadMindfulnessExplanation);
    on<NavigateToSection>(_onNavigateToSection);
  }

  /// [_onLoadMindfulnessExplanation] - Handles loading initial mindfulness explanation data
  /// Simulates data fetching and updates state with loaded information
  Future<void> _onLoadMindfulnessExplanation(
    LoadMindfulnessExplanation event,
    Emitter<MindfulnessExplanationState> emit,
  ) async {
    try {
      // [_onLoadMindfulnessExplanation] Set loading state
      print(
          '[MindfulnessExplanationBloc] Loading mindfulness explanation data');
      emit(state.copyWith(status: MindfulnessExplanationStatus.loading));

      // Simulate API call delay for smooth UX
      await Future.delayed(const Duration(milliseconds: 600));

      // [_onLoadMindfulnessExplanation] Load data with explanation content
      print(
          '[MindfulnessExplanationBloc] Mindfulness explanation data loaded successfully');
      emit(state.copyWith(
        status: MindfulnessExplanationStatus.loaded,
      ));
    } catch (error) {
      // [_onLoadMindfulnessExplanation] Handle error state
      print(
          '[MindfulnessExplanationBloc] Error loading mindfulness explanation: $error');
      emit(state.copyWith(
        status: MindfulnessExplanationStatus.error,
        errorMessage: 'Failed to load explanation data. Please try again.',
      ));
    }
  }

  /// [_onNavigateToSection] - Handles navigation to different sections
  /// Triggered when user taps on "See All" links in different sections
  Future<void> _onNavigateToSection(
    NavigateToSection event,
    Emitter<MindfulnessExplanationState> emit,
  ) async {
    // [_onNavigateToSection] Handle navigation to specific sections
    print(
        '[MindfulnessExplanationBloc] Navigating to section: ${event.sectionName}');
    // This would typically trigger navigation in the UI layer
    // For now, we just log the action
  }
}
