import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mental_health_metrics_event.dart';
part 'mental_health_metrics_state.dart';

/// [MentalHealthMetricsBloc] - BLoC for managing Mental Health Metrics screen state
/// Handles fetching and displaying health metrics data and filtering
class MentalHealthMetricsBloc
    extends Bloc<MentalHealthMetricsEvent, MentalHealthMetricsState> {
  MentalHealthMetricsBloc() : super(MentalHealthMetricsInitial()) {
    on<LoadMentalHealthMetrics>(_onLoadMentalHealthMetrics);
    on<UpdateFilter>(_onUpdateFilter);
  }

  /// [_onLoadMentalHealthMetrics] - Handles loading the mental health metrics data
  Future<void> _onLoadMentalHealthMetrics(
    LoadMentalHealthMetrics event,
    Emitter<MentalHealthMetricsState> emit,
  ) async {
    try {
      emit(MentalHealthMetricsLoading());

      // [MentalHealthMetricsBloc] Simulate loading metrics data
      await Future.delayed(const Duration(milliseconds: 500));

      final metricsData = MentalHealthMetricsData(
        metrics: [
          HealthMetricCard(
            id: 'stress-level',
            title: 'Stress Level',
            value: '4.2',
            unit: 'pts',
            status: 'Stressed Out',
            statusColor: 0xFFFB923C,
            iconPath: 'assets/images/exclamation_mark_triangle_icon.svg',
            chartType: MetricChartType.progressBars,
            weeklyData: ['50', '30', '70', '90', '40', '20', '40'],
          ),
          HealthMetricCard(
            id: 'blood-pressure',
            title: 'Blood Pressure',
            value: '128/80',
            unit: 'mmHg',
            status: 'Stable Range',
            statusColor: 0xFFC084FC,
            iconPath: 'assets/images/water_drop_icon.svg',
            chartType: MetricChartType.barChart,
            weeklyData: ['8', '17', '22', '24', '13', '13', '20'],
          ),
          HealthMetricCard(
            id: 'heart-rate',
            title: 'Heart Rate',
            value: '72',
            unit: 'bpm',
            status: 'Resting Rate',
            statusColor: 0xFFFB7185,
            iconPath: 'assets/images/heart_pulse_icon.svg',
            chartType: MetricChartType.lineChart,
            weeklyData: ['72', '75', '70', '74', '73', '71', '72'],
          ),
          HealthMetricCard(
            id: 'sleep-quality',
            title: 'Sleep Quality',
            value: '3.57',
            unit: 'hr',
            status: 'Insomniac',
            statusColor: 0xFFA8A29E,
            iconPath: 'assets/images/sleep_zzz_icon.svg',
            chartType: MetricChartType.checkmarks,
            weeklyData: [
              'true',
              'false',
              'true',
              'true',
              'false',
              'false',
              'true'
            ],
          ),
          HealthMetricCard(
            id: 'social-connectedness',
            title: 'Social Connectedness',
            value: '998',
            unit: 'kcal',
            status: 'Interacted With',
            statusColor: 0xFF9BB167,
            iconPath: 'assets/images/comment_chat_dot_icon.svg',
            chartType: MetricChartType.circles,
            weeklyData: ['3', '0', '3', '5', '0', '2', '4'],
          ),
          HealthMetricCard(
            id: 'mindfulness-level',
            title: 'Mindfulness Level',
            value: '91.6',
            unit: 'pts',
            status: 'Very Demure',
            statusColor: 0xFFA8A29E,
            iconPath: 'assets/images/leaf_single_icon.svg',
            chartType: MetricChartType.progressBars,
            weeklyData: ['50', '30', '70', '90', '40', '20', '40'],
          ),
          HealthMetricCard(
            id: 'hydration',
            title: 'Hydration',
            value: '1,285',
            unit: 'ml',
            status: 'On Track',
            statusColor: 0xFF60A5FA,
            iconPath: 'assets/images/water_glass_icon.svg',
            chartType: MetricChartType.barChart3Series,
            weeklyData: ['40', '27', '21', '30', '35', '24', '40'],
          ),
        ],
        currentFilter: 'Most Relevant',
      );

      emit(MentalHealthMetricsLoaded(metricsData));
    } catch (e) {
      // [MentalHealthMetricsBloc] Handle loading error
      print('[MentalHealthMetricsBloc] Error loading metrics: $e');
      emit(MentalHealthMetricsError('Failed to load mental health metrics'));
    }
  }

  /// [_onUpdateFilter] - Handles updating the filter selection
  Future<void> _onUpdateFilter(
    UpdateFilter event,
    Emitter<MentalHealthMetricsState> emit,
  ) async {
    final currentState = state;
    if (currentState is MentalHealthMetricsLoaded) {
      // [MentalHealthMetricsBloc] Update filter and potentially reorder metrics
      final updatedData = currentState.metricsData.copyWith(
        currentFilter: event.filter,
      );
      emit(MentalHealthMetricsLoaded(updatedData));
    }
  }
}

/// [MentalHealthMetricsData] - Data model for mental health metrics
class MentalHealthMetricsData {
  final List<HealthMetricCard> metrics;
  final String currentFilter;

  const MentalHealthMetricsData({
    required this.metrics,
    required this.currentFilter,
  });

  MentalHealthMetricsData copyWith({
    List<HealthMetricCard>? metrics,
    String? currentFilter,
  }) {
    return MentalHealthMetricsData(
      metrics: metrics ?? this.metrics,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

/// [HealthMetricCard] - Data model for individual health metric cards
class HealthMetricCard {
  final String id;
  final String title;
  final String value;
  final String unit;
  final String status;
  final int statusColor;
  final String iconPath;
  final MetricChartType chartType;
  final List<String> weeklyData;

  const HealthMetricCard({
    required this.id,
    required this.title,
    required this.value,
    required this.unit,
    required this.status,
    required this.statusColor,
    required this.iconPath,
    required this.chartType,
    required this.weeklyData,
  });
}

/// [MetricChartType] - Enum for different chart types in metrics
enum MetricChartType {
  progressBars,
  barChart,
  lineChart,
  checkmarks,
  circles,
  barChart3Series,
}
