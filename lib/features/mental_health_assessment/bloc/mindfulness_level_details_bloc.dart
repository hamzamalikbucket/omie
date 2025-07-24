import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mindfulness_level_details_event.dart';
part 'mindfulness_level_details_state.dart';

/// [MindfulnessLevelDetailsBloc] - Business logic component for mindfulness level details screen
/// Manages state changes, data loading, and user interactions for the detailed metrics screen
/// Following Apple's Human Interface Guidelines for smooth state transitions and user feedback
class MindfulnessLevelDetailsBloc
    extends Bloc<MindfulnessLevelDetailsEvent, MindfulnessLevelDetailsState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  MindfulnessLevelDetailsBloc() : super(const MindfulnessLevelDetailsState()) {
    // Register event handlers for different user actions
    on<LoadMindfulnessLevelDetails>(_onLoadMindfulnessLevelDetails);
    on<ViewInsight>(_onViewInsight);
    on<ConsultAIAssistant>(_onConsultAIAssistant);
    on<RefreshDetails>(_onRefreshDetails);
  }

  /// [_onLoadMindfulnessLevelDetails] - Handles loading initial mindfulness level details data
  /// Simulates data fetching and updates state with loaded details
  Future<void> _onLoadMindfulnessLevelDetails(
    LoadMindfulnessLevelDetails event,
    Emitter<MindfulnessLevelDetailsState> emit,
  ) async {
    try {
      // [_onLoadMindfulnessLevelDetails] Set loading state
      print(
          '[MindfulnessLevelDetailsBloc] Loading mindfulness level details data');
      emit(state.copyWith(status: MindfulnessLevelDetailsStatus.loading));

      // Simulate API call delay for smooth UX
      await Future.delayed(const Duration(milliseconds: 600));

      // [_onLoadMindfulnessLevelDetails] Load data with details
      print(
          '[MindfulnessLevelDetailsBloc] Mindfulness level details data loaded successfully');
      emit(state.copyWith(
        status: MindfulnessLevelDetailsStatus.loaded,
      ));
    } catch (error) {
      // [_onLoadMindfulnessLevelDetails] Handle error state
      print(
          '[MindfulnessLevelDetailsBloc] Error loading mindfulness level details: $error');
      emit(state.copyWith(
        status: MindfulnessLevelDetailsStatus.error,
        errorMessage: 'Failed to load details data. Please try again.',
      ));
    }
  }

  /// [_onViewInsight] - Handles viewing detailed insights
  /// Triggered when user taps on "View Insight" button
  Future<void> _onViewInsight(
    ViewInsight event,
    Emitter<MindfulnessLevelDetailsState> emit,
  ) async {
    // [_onViewInsight] Handle view insight action
    print('[MindfulnessLevelDetailsBloc] View Insight button pressed');
    // This would typically trigger navigation to insights screen
  }

  /// [_onConsultAIAssistant] - Handles consulting AI assistant
  /// Triggered when user taps on "Consult AI Assistant" button
  Future<void> _onConsultAIAssistant(
    ConsultAIAssistant event,
    Emitter<MindfulnessLevelDetailsState> emit,
  ) async {
    // [_onConsultAIAssistant] Handle AI assistant consultation
    print('[MindfulnessLevelDetailsBloc] Consult AI Assistant button pressed');
    // This would typically trigger navigation to AI assistant or chat interface
  }

  /// [_onRefreshDetails] - Handles refreshing the details data
  /// Reloads all details and updates the state
  Future<void> _onRefreshDetails(
    RefreshDetails event,
    Emitter<MindfulnessLevelDetailsState> emit,
  ) async {
    // [_onRefreshDetails] Refresh details data
    print('[MindfulnessLevelDetailsBloc] Refreshing details data');

    // Trigger a reload of the details data
    add(const LoadMindfulnessLevelDetails());
  }
}
