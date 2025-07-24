part of 'mindfulness_insight_bloc.dart';

/// [MindfulnessInsightStatus] - Enumeration for different states of the mindfulness insight
/// Used to manage loading, success, and error states
enum MindfulnessInsightStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when fetching data
  loading,

  /// Success state when data is loaded successfully
  loaded,

  /// Error state when there's an issue loading data
  error,
}

/// [TrendData] - Model for monthly trend data
class TrendData extends Equatable {
  /// [score] - The current trend score
  final String score;

  /// [percentage] - The percentage change vs last month
  final String percentage;

  /// [isPositive] - Whether the trend is positive
  final bool isPositive;

  /// [chartData] - Data points for the chart visualization
  final List<ChartDataPoint> chartData;

  /// [legendItems] - Legend items for the chart
  final List<LegendItem> legendItems;

  const TrendData({
    required this.score,
    required this.percentage,
    required this.isPositive,
    required this.chartData,
    required this.legendItems,
  });

  @override
  List<Object> get props =>
      [score, percentage, isPositive, chartData, legendItems];
}

/// [ChartDataPoint] - Model for individual chart data points
class ChartDataPoint extends Equatable {
  /// [label] - The label for this data point
  final String label;

  /// [value] - The normalized value (0.0 to 1.0)
  final double value;

  /// [color] - The color for this data point
  final int color;

  const ChartDataPoint({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  List<Object> get props => [label, value, color];
}

/// [LegendItem] - Model for chart legend items
class LegendItem extends Equatable {
  /// [label] - The legend label
  final String label;

  /// [color] - The legend color
  final int color;

  const LegendItem({
    required this.label,
    required this.color,
  });

  @override
  List<Object> get props => [label, color];
}

/// [MindfulMoment] - Model for most mindful moment data
class MindfulMoment extends Equatable {
  /// [timeOfDay] - Time of day (e.g., "Evening")
  final String timeOfDay;

  /// [timeRange] - Specific time range (e.g., "10 AM - 2 PM, PST")
  final String timeRange;

  /// [description] - Description of the mindful moment
  final String description;

  /// [activities] - List of activities during this moment
  final List<MindfulActivity> activities;

  const MindfulMoment({
    required this.timeOfDay,
    required this.timeRange,
    required this.description,
    required this.activities,
  });

  @override
  List<Object> get props => [timeOfDay, timeRange, description, activities];
}

/// [MindfulActivity] - Model for individual mindful activities
class MindfulActivity extends Equatable {
  /// [value] - The activity value (e.g., "10m", "2")
  final String value;

  /// [label] - The activity label (e.g., "Meditation", "Entries")
  final String label;

  const MindfulActivity({
    required this.value,
    required this.label,
  });

  @override
  List<Object> get props => [value, label];
}

/// [MindfulnessInsightState] - State class containing all mindfulness insight data
/// Manages trends, moments, filters, and user interactions for the insight screen
class MindfulnessInsightState extends Equatable {
  /// [status] - Current status of the mindfulness insight screen
  final MindfulnessInsightStatus status;

  /// [description] - Description text about mindfulness impact
  final String description;

  /// [selectedDateFilter] - Currently selected date filter
  final String selectedDateFilter;

  /// [trendData] - Monthly trend data and visualization
  final TrendData trendData;

  /// [mindfulMoment] - Most mindful moment insights
  final MindfulMoment mindfulMoment;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  const MindfulnessInsightState({
    this.status = MindfulnessInsightStatus.initial,
    this.description =
        'A closer look at your daily mindfulness level and its impact on your mental heatlh.',
    this.selectedDateFilter = 'January 2025',
    this.trendData = const TrendData(
      score: '20.08',
      percentage: '+2.55% vs last month',
      isPositive: true,
      chartData: [
        ChartDataPoint(label: '20', value: 0.6, color: 0xFFE7E5E4),
        ChartDataPoint(label: '21', value: 0.9, color: 0xFFF08C51),
      ],
      legendItems: [
        LegendItem(label: 'Last Month', color: 0xFFE7E5E4),
        LegendItem(label: 'This Month', color: 0xFFF08C51),
      ],
    ),
    this.mindfulMoment = const MindfulMoment(
      timeOfDay: 'Evening',
      timeRange: '10 AM - 2 PM, PST',
      description: 'You are at your most mindful during the evening',
      activities: [
        MindfulActivity(value: '10m', label: 'Meditation'),
        MindfulActivity(value: '2', label: 'Entries'),
        MindfulActivity(value: '5m', label: 'Breathing'),
      ],
    ),
    this.errorMessage,
  });

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  MindfulnessInsightState copyWith({
    MindfulnessInsightStatus? status,
    String? description,
    String? selectedDateFilter,
    TrendData? trendData,
    MindfulMoment? mindfulMoment,
    String? errorMessage,
  }) {
    return MindfulnessInsightState(
      status: status ?? this.status,
      description: description ?? this.description,
      selectedDateFilter: selectedDateFilter ?? this.selectedDateFilter,
      trendData: trendData ?? this.trendData,
      mindfulMoment: mindfulMoment ?? this.mindfulMoment,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        description,
        selectedDateFilter,
        trendData,
        mindfulMoment,
        errorMessage,
      ];
}
