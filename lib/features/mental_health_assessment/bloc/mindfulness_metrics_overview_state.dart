part of 'mindfulness_metrics_overview_bloc.dart';

/// [MindfulnessMetricsOverviewStatus] - Enumeration for different states of the mindfulness metrics overview
/// Used to manage loading, success, and error states
enum MindfulnessMetricsOverviewStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when fetching data
  loading,

  /// Success state when data is loaded successfully
  loaded,

  /// Error state when there's an issue loading data
  error,
}

/// [OverviewMetricEntry] - Model for individual metric entries in overview
class OverviewMetricEntry extends Equatable {
  /// [iconPath] - Path to the icon asset
  final String iconPath;

  /// [label] - The label for the metric
  final String label;

  /// [value] - The value of the metric
  final String value;

  /// [hasUpArrow] - Whether this metric has an up arrow indicator
  final bool hasUpArrow;

  const OverviewMetricEntry({
    required this.iconPath,
    required this.label,
    required this.value,
    this.hasUpArrow = false,
  });

  @override
  List<Object> get props => [iconPath, label, value, hasUpArrow];
}

/// [MindfulnessMetricsOverviewState] - State class containing all mindfulness metrics overview data
/// Manages score, date/time info, metrics, and user interactions for the overview screen
class MindfulnessMetricsOverviewState extends Equatable {
  /// [status] - Current status of the mindfulness metrics overview screen
  final MindfulnessMetricsOverviewStatus status;

  /// [score] - Current mindfulness score (e.g., "72.8")
  final String score;

  /// [statusMessage] - Status message displayed below the score
  final String statusMessage;

  /// [date] - Date string for the entry
  final String date;

  /// [time] - Time string for the entry
  final String time;

  /// [description] - Description text about the mindfulness state
  final String description;

  /// [metrics] - List of key metrics to display in overview
  final List<OverviewMetricEntry> metrics;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  const MindfulnessMetricsOverviewState({
    this.status = MindfulnessMetricsOverviewStatus.initial,
    this.score = '72.8',
    this.statusMessage = 'Moderately Mindful',
    this.date = 'Friday, Jun 23, 2028',
    this.time = '00:01 AM',
    this.description =
        'You\'ve stayed focused and present for most of the day. Great job maintaining awareness!',
    this.metrics = const [
      OverviewMetricEntry(
        iconPath: 'assets/images/leaf_single_icon.svg',
        label: 'Level',
        value: '72.8pts',
      ),
      OverviewMetricEntry(
        iconPath: 'assets/images/book_open_icon.svg',
        label: 'Daily Journal Completed?',
        value: 'Yes',
      ),
      OverviewMetricEntry(
        iconPath: 'assets/images/exclamation_mark_triangle_icon.svg',
        label: 'Stress Level',
        value: '-8%',
        hasUpArrow: true,
      ),
      OverviewMetricEntry(
        iconPath: 'assets/images/heart_icon.svg',
        label: 'Gratitude Affirmation',
        value: '8',
      ),
      OverviewMetricEntry(
        iconPath: 'assets/images/calendar_icon.svg',
        label: 'Monthly Average',
        value: '160',
      ),
      OverviewMetricEntry(
        iconPath: 'assets/images/chart_bubble_icon.svg',
        label: 'Trend',
        value: '-15% vs last month',
      ),
    ],
    this.errorMessage,
  });

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  MindfulnessMetricsOverviewState copyWith({
    MindfulnessMetricsOverviewStatus? status,
    String? score,
    String? statusMessage,
    String? date,
    String? time,
    String? description,
    List<OverviewMetricEntry>? metrics,
    String? errorMessage,
  }) {
    return MindfulnessMetricsOverviewState(
      status: status ?? this.status,
      score: score ?? this.score,
      statusMessage: statusMessage ?? this.statusMessage,
      date: date ?? this.date,
      time: time ?? this.time,
      description: description ?? this.description,
      metrics: metrics ?? this.metrics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        score,
        statusMessage,
        date,
        time,
        description,
        metrics,
        errorMessage,
      ];
}
