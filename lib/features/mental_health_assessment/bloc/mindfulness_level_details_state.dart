part of 'mindfulness_level_details_bloc.dart';

/// [MindfulnessLevelDetailsStatus] - Enumeration for different states of the mindfulness level details
/// Used to manage loading, success, and error states
enum MindfulnessLevelDetailsStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when fetching data
  loading,

  /// Success state when data is loaded successfully
  loaded,

  /// Error state when there's an issue loading data
  error,
}

/// [MetricEntry] - Model for individual metric entries
class MetricEntry extends Equatable {
  /// [iconPath] - Path to the icon asset
  final String iconPath;

  /// [label] - The label for the metric
  final String label;

  /// [value] - The value of the metric
  final String value;

  /// [hasUpArrow] - Whether this metric has an up arrow indicator
  final bool hasUpArrow;

  const MetricEntry({
    required this.iconPath,
    required this.label,
    required this.value,
    this.hasUpArrow = false,
  });

  @override
  List<Object> get props => [iconPath, label, value, hasUpArrow];
}

/// [MindfulnessLevelDetailsState] - State class containing all mindfulness level details data
/// Manages score, date/time info, metrics, and user interactions
class MindfulnessLevelDetailsState extends Equatable {
  /// [status] - Current status of the mindfulness level details screen
  final MindfulnessLevelDetailsStatus status;

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

  /// [metrics] - List of key metrics to display
  final List<MetricEntry> metrics;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  const MindfulnessLevelDetailsState({
    this.status = MindfulnessLevelDetailsStatus.initial,
    this.score = '72.8',
    this.statusMessage = 'Moderately Mindful',
    this.date = 'Friday, Jun 23, 2028',
    this.time = '00:01 AM',
    this.description =
        'You\'ve stayed focused and present for most of the day. Great job maintaining awareness!',
    this.metrics = const [
      MetricEntry(
        iconPath: 'assets/images/leaf_single_icon.svg',
        label: 'Level',
        value: '72.8pts',
      ),
      MetricEntry(
        iconPath: 'assets/images/book_open_icon.svg',
        label: 'Daily Journal Completed?',
        value: 'Yes',
      ),
      MetricEntry(
        iconPath: 'assets/images/exclamation_mark_triangle_icon.svg',
        label: 'Stress Level',
        value: '-8%',
        hasUpArrow: true,
      ),
      MetricEntry(
        iconPath: 'assets/images/heart_icon.svg',
        label: 'Gratitude Affirmation',
        value: '8',
      ),
      MetricEntry(
        iconPath: 'assets/images/calendar_icon.svg',
        label: 'Monthly Average',
        value: '160',
      ),
      MetricEntry(
        iconPath: 'assets/images/chart_bubble_icon.svg',
        label: 'Trend',
        value: '-15% vs last month',
      ),
    ],
    this.errorMessage,
  });

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  MindfulnessLevelDetailsState copyWith({
    MindfulnessLevelDetailsStatus? status,
    String? score,
    String? statusMessage,
    String? date,
    String? time,
    String? description,
    List<MetricEntry>? metrics,
    String? errorMessage,
  }) {
    return MindfulnessLevelDetailsState(
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
