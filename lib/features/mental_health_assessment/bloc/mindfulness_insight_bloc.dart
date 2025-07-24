import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mindfulness_insight_event.dart';
part 'mindfulness_insight_state.dart';

/// [MindfulnessInsightBloc] - Business logic component for mindfulness insight screen
/// Manages state changes, data loading, and user interactions for the comprehensive insight dashboard
/// Following Apple's Human Interface Guidelines for smooth state transitions and user feedback
class MindfulnessInsightBloc
    extends Bloc<MindfulnessInsightEvent, MindfulnessInsightState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  MindfulnessInsightBloc() : super(const MindfulnessInsightState()) {
    // Register event handlers for different user actions
    on<LoadMindfulnessInsight>(_onLoadMindfulnessInsight);
    on<ChangeDateFilter>(_onChangeDateFilter);
    on<ViewTrendDetails>(_onViewTrendDetails);
    on<ViewMomentDetails>(_onViewMomentDetails);
    on<RefreshInsightData>(_onRefreshInsightData);
  }

  /// [_onLoadMindfulnessInsight] - Handles loading initial mindfulness insight data
  /// Simulates data fetching and updates state with loaded insight analytics
  Future<void> _onLoadMindfulnessInsight(
    LoadMindfulnessInsight event,
    Emitter<MindfulnessInsightState> emit,
  ) async {
    try {
      // [_onLoadMindfulnessInsight] Set loading state
      print('[MindfulnessInsightBloc] Loading mindfulness insight data');
      emit(state.copyWith(status: MindfulnessInsightStatus.loading));

      // Simulate API call delay for smooth UX
      await Future.delayed(const Duration(milliseconds: 600));

      // [_onLoadMindfulnessInsight] Load insight data successfully
      print(
          '[MindfulnessInsightBloc] Mindfulness insight data loaded successfully');
      emit(state.copyWith(
        status: MindfulnessInsightStatus.loaded,
      ));
    } catch (error) {
      // [_onLoadMindfulnessInsight] Handle error state
      print(
          '[MindfulnessInsightBloc] Error loading mindfulness insight: $error');
      emit(state.copyWith(
        status: MindfulnessInsightStatus.error,
        errorMessage: 'Failed to load insight data. Please try again.',
      ));
    }
  }

  /// [_onChangeDateFilter] - Handles changing the date filter
  /// Updates the selected date filter and potentially refreshes data
  Future<void> _onChangeDateFilter(
    ChangeDateFilter event,
    Emitter<MindfulnessInsightState> emit,
  ) async {
    // [_onChangeDateFilter] Update date filter
    print(
        '[MindfulnessInsightBloc] Changing date filter to: ${event.dateFilter}');

    emit(state.copyWith(
      selectedDateFilter: event.dateFilter,
      status: MindfulnessInsightStatus.loading,
    ));

    // Simulate loading new data for the selected period
    await Future.delayed(const Duration(milliseconds: 400));

    emit(state.copyWith(
      status: MindfulnessInsightStatus.loaded,
    ));
  }

  /// [_onViewTrendDetails] - Handles viewing trend details
  /// Triggered when user taps on "See All" in trend section
  Future<void> _onViewTrendDetails(
    ViewTrendDetails event,
    Emitter<MindfulnessInsightState> emit,
  ) async {
    // [_onViewTrendDetails] Handle view trend details action
    print('[MindfulnessInsightBloc] View Trend Details button pressed');
    // This would typically trigger navigation to detailed trend screen
  }

  /// [_onViewMomentDetails] - Handles viewing mindful moment details
  /// Triggered when user taps on "See All" in moment section
  Future<void> _onViewMomentDetails(
    ViewMomentDetails event,
    Emitter<MindfulnessInsightState> emit,
  ) async {
    // [_onViewMomentDetails] Handle view moment details action
    print('[MindfulnessInsightBloc] View Moment Details button pressed');
    // This would typically trigger navigation to detailed moment insights screen
  }

  /// [_onRefreshInsightData] - Handles refreshing the insight data
  /// Reloads all insight analytics and updates the state
  Future<void> _onRefreshInsightData(
    RefreshInsightData event,
    Emitter<MindfulnessInsightState> emit,
  ) async {
    // [_onRefreshInsightData] Refresh insight data
    print('[MindfulnessInsightBloc] Refreshing insight data');

    // Trigger a reload of the insight data
    add(const LoadMindfulnessInsight());
  }
}
