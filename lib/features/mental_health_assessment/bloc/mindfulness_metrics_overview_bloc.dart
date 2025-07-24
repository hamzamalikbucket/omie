import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mindfulness_metrics_overview_event.dart';
part 'mindfulness_metrics_overview_state.dart';

/// [MindfulnessMetricsOverviewBloc] - Business logic component for mindfulness metrics overview screen
/// Manages state changes, data loading, and user interactions for the comprehensive metrics overview
/// Following Apple's Human Interface Guidelines for smooth state transitions and user feedback
class MindfulnessMetricsOverviewBloc extends Bloc<
    MindfulnessMetricsOverviewEvent, MindfulnessMetricsOverviewState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  MindfulnessMetricsOverviewBloc()
      : super(const MindfulnessMetricsOverviewState()) {
    // Register event handlers for different user actions
    on<LoadMindfulnessMetricsOverview>(_onLoadMindfulnessMetricsOverview);
    on<ViewInsightFromOverview>(_onViewInsightFromOverview);
    on<ConsultAIAssistantFromOverview>(_onConsultAIAssistantFromOverview);
    on<RefreshOverviewData>(_onRefreshOverviewData);
  }

  /// [_onLoadMindfulnessMetricsOverview] - Handles loading initial mindfulness metrics overview data
  /// Simulates data fetching and updates state with loaded overview details
  Future<void> _onLoadMindfulnessMetricsOverview(
    LoadMindfulnessMetricsOverview event,
    Emitter<MindfulnessMetricsOverviewState> emit,
  ) async {
    try {
      // [_onLoadMindfulnessMetricsOverview] Set loading state
      print(
          '[MindfulnessMetricsOverviewBloc] Loading mindfulness metrics overview data');
      emit(state.copyWith(status: MindfulnessMetricsOverviewStatus.loading));

      // Simulate API call delay for smooth UX
      await Future.delayed(const Duration(milliseconds: 600));

      // [_onLoadMindfulnessMetricsOverview] Load overview data successfully
      print(
          '[MindfulnessMetricsOverviewBloc] Mindfulness metrics overview data loaded successfully');
      emit(state.copyWith(
        status: MindfulnessMetricsOverviewStatus.loaded,
      ));
    } catch (error) {
      // [_onLoadMindfulnessMetricsOverview] Handle error state
      print(
          '[MindfulnessMetricsOverviewBloc] Error loading mindfulness metrics overview: $error');
      emit(state.copyWith(
        status: MindfulnessMetricsOverviewStatus.error,
        errorMessage: 'Failed to load overview data. Please try again.',
      ));
    }
  }

  /// [_onViewInsightFromOverview] - Handles viewing detailed insights from overview
  /// Triggered when user taps on "View Insight" button in overview
  Future<void> _onViewInsightFromOverview(
    ViewInsightFromOverview event,
    Emitter<MindfulnessMetricsOverviewState> emit,
  ) async {
    // [_onViewInsightFromOverview] Handle view insight action from overview
    print(
        '[MindfulnessMetricsOverviewBloc] View Insight button pressed from overview');
    // This would typically trigger navigation to insights screen
  }

  /// [_onConsultAIAssistantFromOverview] - Handles consulting AI assistant from overview
  /// Triggered when user taps on "Consult AI Assistant" button in overview
  Future<void> _onConsultAIAssistantFromOverview(
    ConsultAIAssistantFromOverview event,
    Emitter<MindfulnessMetricsOverviewState> emit,
  ) async {
    // [_onConsultAIAssistantFromOverview] Handle AI assistant consultation from overview
    print(
        '[MindfulnessMetricsOverviewBloc] Consult AI Assistant button pressed from overview');
    // This would typically trigger navigation to AI assistant or chat interface
  }

  /// [_onRefreshOverviewData] - Handles refreshing the overview data
  /// Reloads all overview details and updates the state
  Future<void> _onRefreshOverviewData(
    RefreshOverviewData event,
    Emitter<MindfulnessMetricsOverviewState> emit,
  ) async {
    // [_onRefreshOverviewData] Refresh overview data
    print('[MindfulnessMetricsOverviewBloc] Refreshing overview data');

    // Trigger a reload of the overview data
    add(const LoadMindfulnessMetricsOverview());
  }
}
