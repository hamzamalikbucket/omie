import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wellness_score_detail_event.dart';
part 'wellness_score_detail_state.dart';

/// [WellnessScoreDetailBloc] - Business logic component for wellness score detail screen
/// Manages state changes, data loading, and user interactions for the wellness score detail page
/// Following Apple's Human Interface Guidelines for smooth state transitions and user feedback
class WellnessScoreDetailBloc
    extends Bloc<WellnessScoreDetailEvent, WellnessScoreDetailState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  WellnessScoreDetailBloc() : super(const WellnessScoreDetailState()) {
    // Register event handlers for different user actions
    on<LoadWellnessScoreDetail>(_onLoadWellnessScoreDetail);
    on<ChangeTimePeriod>(_onChangeTimePeriod);
    on<RefreshWellnessData>(_onRefreshWellnessData);
  }

  /// [_onLoadWellnessScoreDetail] - Handles loading initial wellness score data
  /// Simulates data fetching and updates state with loaded information
  Future<void> _onLoadWellnessScoreDetail(
    LoadWellnessScoreDetail event,
    Emitter<WellnessScoreDetailState> emit,
  ) async {
    try {
      // [_onLoadWellnessScoreDetail] Set loading state
      print('[WellnessScoreDetailBloc] Loading wellness score detail data');
      emit(state.copyWith(status: WellnessScoreDetailStatus.loading));

      // Simulate API call delay for smooth UX
      await Future.delayed(const Duration(milliseconds: 800));

      // [_onLoadWellnessScoreDetail] Load default data with wellness score and chart
      print(
          '[WellnessScoreDetailBloc] Wellness score detail data loaded successfully');
      emit(state.copyWith(
        status: WellnessScoreDetailStatus.loaded,
        score: '88.1',
        statusMessage: 'You are mindfully present. ??',
        selectedTimePeriod: 'All Time',
        chartDataPoints: const [0.6, 0.4, 0.9, 0.2, 0.7, 0.5, 0.1],
        xAxisLabels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      ));
    } catch (error) {
      // [_onLoadWellnessScoreDetail] Handle error state
      print(
          '[WellnessScoreDetailBloc] Error loading wellness score detail: $error');
      emit(state.copyWith(
        status: WellnessScoreDetailStatus.error,
        errorMessage: 'Failed to load wellness data. Please try again.',
      ));
    }
  }

  /// [_onChangeTimePeriod] - Handles time period selection changes
  /// Updates chart data based on selected time period (1d, 1w, 1m, 1y, All Time)
  Future<void> _onChangeTimePeriod(
    ChangeTimePeriod event,
    Emitter<WellnessScoreDetailState> emit,
  ) async {
    try {
      // [_onChangeTimePeriod] Update selected time period immediately for responsive UI
      print(
          '[WellnessScoreDetailBloc] Changing time period to: ${event.timePeriod}');
      emit(state.copyWith(
        status: WellnessScoreDetailStatus.loading,
        selectedTimePeriod: event.timePeriod,
      ));

      // Simulate loading new chart data based on time period
      await Future.delayed(const Duration(milliseconds: 400));

      // Generate different chart data based on selected time period
      List<double> newChartData;
      List<String> newLabels;

      switch (event.timePeriod) {
        case '1d':
          // Hourly data for one day
          newChartData = const [0.8, 0.7, 0.9, 0.6, 0.8, 0.5, 0.7];
          newLabels = const ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM', '12AM'];
          break;
        case '1w':
          // Daily data for one week
          newChartData = const [0.6, 0.4, 0.9, 0.2, 0.7, 0.5, 0.8];
          newLabels = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          break;
        case '1m':
          // Weekly data for one month
          newChartData = const [0.7, 0.5, 0.8, 0.6];
          newLabels = const ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
          break;
        case '1y':
          // Monthly data for one year
          newChartData = const [0.6, 0.7, 0.8, 0.5, 0.9, 0.7, 0.8];
          newLabels = const ['Jan', 'Mar', 'May', 'Jul', 'Sep', 'Nov', 'Dec'];
          break;
        case 'All Time':
        default:
          // Default all-time data
          newChartData = const [0.6, 0.4, 0.9, 0.2, 0.7, 0.5, 0.1];
          newLabels = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          break;
      }

      // [_onChangeTimePeriod] Emit updated state with new chart data
      print(
          '[WellnessScoreDetailBloc] Time period changed successfully to: ${event.timePeriod}');
      emit(state.copyWith(
        status: WellnessScoreDetailStatus.loaded,
        chartDataPoints: newChartData,
        xAxisLabels: newLabels,
      ));
    } catch (error) {
      // [_onChangeTimePeriod] Handle error during time period change
      print('[WellnessScoreDetailBloc] Error changing time period: $error');
      emit(state.copyWith(
        status: WellnessScoreDetailStatus.error,
        errorMessage: 'Failed to update chart data. Please try again.',
      ));
    }
  }

  /// [_onRefreshWellnessData] - Handles manual data refresh
  /// Reloads wellness data when user pulls to refresh
  Future<void> _onRefreshWellnessData(
    RefreshWellnessData event,
    Emitter<WellnessScoreDetailState> emit,
  ) async {
    try {
      // [_onRefreshWellnessData] Refresh wellness data
      print('[WellnessScoreDetailBloc] Refreshing wellness data');
      emit(state.copyWith(status: WellnessScoreDetailStatus.loading));

      // Simulate refresh delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Generate slightly updated data to show refresh
      final refreshedScore =
          (88.1 + (DateTime.now().millisecond % 10) * 0.1).toStringAsFixed(1);

      // [_onRefreshWellnessData] Emit refreshed data
      print('[WellnessScoreDetailBloc] Wellness data refreshed successfully');
      emit(state.copyWith(
        status: WellnessScoreDetailStatus.loaded,
        score: refreshedScore,
        statusMessage: 'You are mindfully present. ??',
      ));
    } catch (error) {
      // [_onRefreshWellnessData] Handle refresh error
      print('[WellnessScoreDetailBloc] Error refreshing wellness data: $error');
      emit(state.copyWith(
        status: WellnessScoreDetailStatus.error,
        errorMessage: 'Failed to refresh data. Please try again.',
      ));
    }
  }
}
