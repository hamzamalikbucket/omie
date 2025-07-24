part of 'wellness_score_detail_bloc.dart';

/// [WellnessScoreDetailStatus] - Enumeration for different states of the wellness score detail
/// Used to manage loading, success, and error states
enum WellnessScoreDetailStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when fetching wellness data
  loading,

  /// Success state when data is loaded successfully
  loaded,

  /// Error state when there's an issue loading data
  error,
}

/// [WellnessHistoryEntry] - Model for individual history entries
class WellnessHistoryEntry extends Equatable {
  /// [score] - The wellness score for this entry
  final String score;

  /// [status] - The mindfulness level status
  final String status;

  /// [time] - The time this entry was recorded
  final String time;

  const WellnessHistoryEntry({
    required this.score,
    required this.status,
    required this.time,
  });

  @override
  List<Object> get props => [score, status, time];
}

/// [WellnessScoreDetailState] - State class containing all wellness score detail data
/// Manages score information, chart data, selected time period, insights, history, and goals
class WellnessScoreDetailState extends Equatable {
  /// [status] - Current status of the wellness score detail screen
  final WellnessScoreDetailStatus status;

  /// [score] - Current wellness score (e.g., "88.1")
  final String score;

  /// [statusMessage] - Status message displayed below the score
  final String statusMessage;

  /// [selectedTimePeriod] - Currently selected time period tab
  final String selectedTimePeriod;

  /// [chartDataPoints] - Data points for the line chart
  /// List of y-coordinates for each day/time point
  final List<double> chartDataPoints;

  /// [xAxisLabels] - Labels for the x-axis of the chart
  final List<String> xAxisLabels;

  /// [monthlyAverage] - Monthly average score for insights section
  final String monthlyAverage;

  /// [monthlyTrend] - Monthly trend percentage (e.g., "-8%")
  final String monthlyTrend;

  /// [isPositiveTrend] - Whether the trend is positive or negative
  final bool isPositiveTrend;

  /// [insightDescription] - Description text for the insight section
  final String insightDescription;

  /// [historyEntries] - List of historical wellness entries
  final List<WellnessHistoryEntry> historyEntries;

  /// [goalTarget] - Target wellness score (e.g., ">75pts")
  final String goalTarget;

  /// [goalDescription] - Description of the wellness goal
  final String goalDescription;

  /// [goalProgress] - Progress percentage (0.0 to 1.0)
  final double goalProgress;

  /// [goalProgressText] - Progress text (e.g., "30%")
  final String goalProgressText;

  /// [goalTotalText] - Total goal text (e.g., "2,500 Total")
  final String goalTotalText;

  /// [goalAdvice] - Advice text for achieving the goal
  final String goalAdvice;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  const WellnessScoreDetailState({
    this.status = WellnessScoreDetailStatus.initial,
    this.score = '88.1',
    this.statusMessage = 'You are mindfully present. ??',
    this.selectedTimePeriod = 'All Time',
    this.chartDataPoints = const [0.6, 0.4, 0.9, 0.2, 0.7, 0.5, 0.1],
    this.xAxisLabels = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    this.monthlyAverage = '72.8pts',
    this.monthlyTrend = '-8% vs last month',
    this.isPositiveTrend = false,
    this.insightDescription =
        'Fully Engaged and and feeling deeply connected, calm, and focused throughout your day.',
    this.historyEntries = const [
      WellnessHistoryEntry(
          score: '78 pts', status: 'Somewhat Mindful', time: '10:25 AM'),
      WellnessHistoryEntry(
          score: '70 pts', status: 'Mindful Enough', time: '11:23 AM'),
      WellnessHistoryEntry(
          score: '61 pts', status: 'Less Mindful', time: '12:11 PM'),
    ],
    this.goalTarget = '>75pts',
    this.goalDescription = 'Mindfulness Level Goal',
    this.goalProgress = 0.3,
    this.goalProgressText = '30%',
    this.goalTotalText = '2,500 Total',
    this.goalAdvice =
        'You\'re on track! Keep taking steps daily to improve your health & overall score.',
    this.errorMessage,
  });

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  WellnessScoreDetailState copyWith({
    WellnessScoreDetailStatus? status,
    String? score,
    String? statusMessage,
    String? selectedTimePeriod,
    List<double>? chartDataPoints,
    List<String>? xAxisLabels,
    String? monthlyAverage,
    String? monthlyTrend,
    bool? isPositiveTrend,
    String? insightDescription,
    List<WellnessHistoryEntry>? historyEntries,
    String? goalTarget,
    String? goalDescription,
    double? goalProgress,
    String? goalProgressText,
    String? goalTotalText,
    String? goalAdvice,
    String? errorMessage,
  }) {
    return WellnessScoreDetailState(
      status: status ?? this.status,
      score: score ?? this.score,
      statusMessage: statusMessage ?? this.statusMessage,
      selectedTimePeriod: selectedTimePeriod ?? this.selectedTimePeriod,
      chartDataPoints: chartDataPoints ?? this.chartDataPoints,
      xAxisLabels: xAxisLabels ?? this.xAxisLabels,
      monthlyAverage: monthlyAverage ?? this.monthlyAverage,
      monthlyTrend: monthlyTrend ?? this.monthlyTrend,
      isPositiveTrend: isPositiveTrend ?? this.isPositiveTrend,
      insightDescription: insightDescription ?? this.insightDescription,
      historyEntries: historyEntries ?? this.historyEntries,
      goalTarget: goalTarget ?? this.goalTarget,
      goalDescription: goalDescription ?? this.goalDescription,
      goalProgress: goalProgress ?? this.goalProgress,
      goalProgressText: goalProgressText ?? this.goalProgressText,
      goalTotalText: goalTotalText ?? this.goalTotalText,
      goalAdvice: goalAdvice ?? this.goalAdvice,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        score,
        statusMessage,
        selectedTimePeriod,
        chartDataPoints,
        xAxisLabels,
        monthlyAverage,
        monthlyTrend,
        isPositiveTrend,
        insightDescription,
        historyEntries,
        goalTarget,
        goalDescription,
        goalProgress,
        goalProgressText,
        goalTotalText,
        goalAdvice,
        errorMessage,
      ];
}
