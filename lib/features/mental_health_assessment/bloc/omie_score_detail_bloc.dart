import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'omie_score_detail_event.dart';
part 'omie_score_detail_state.dart';

/// [OmieScoreDetailBloc] - BLoC for managing Omie Score Detail screen state
/// Handles fetching and displaying detailed score information
class OmieScoreDetailBloc
    extends Bloc<OmieScoreDetailEvent, OmieScoreDetailState> {
  OmieScoreDetailBloc() : super(OmieScoreDetailInitial()) {
    on<LoadOmieScoreDetail>(_onLoadOmieScoreDetail);
    on<UpdateSelectedTimeFrame>(_onUpdateSelectedTimeFrame);
  }

  /// [_onLoadOmieScoreDetail] - Handles loading the Omie Score detail data
  Future<void> _onLoadOmieScoreDetail(
    LoadOmieScoreDetail event,
    Emitter<OmieScoreDetailState> emit,
  ) async {
    try {
      emit(OmieScoreDetailLoading());

      // Simulate API call - in real app, this would fetch from API
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data matching the Figma design
      final scoreData = OmieScoreData(
        currentScore: 88,
        maxScore: 100,
        lastUpdated: DateTime.now().subtract(const Duration(seconds: 3)),
        description:
            "You are a very healthy individual. There's still room for improvement.",
        scoreBreakdown: [
          ScoreBreakdownItem(
            range: "10 - 15",
            category: "Depressed",
            color: 0xFFC084FC,
          ),
          ScoreBreakdownItem(
            range: "15 - 40",
            category: "Stressed",
            color: 0xFFF43F5E,
          ),
          ScoreBreakdownItem(
            range: "40 - 70",
            category: "Moderate",
            color: 0xFFFB923C,
          ),
          ScoreBreakdownItem(
            range: "70 - 100",
            category: "Thriving",
            color: 0xFF9BB167,
          ),
        ],
        healthMetrics: [
          HealthMetric(
            title: "Physical Health",
            status: "Excellent",
            progress: 0.9,
            description: "Optimal physical health",
            color: 0xFF9BB167,
          ),
          HealthMetric(
            title: "Mental Health",
            status: "Bad",
            progress: 0.3,
            description: "Needs a few improvement",
            color: 0xFFFB7185,
          ),
          HealthMetric(
            title: "Stress Level",
            status: "Good",
            progress: 0.7,
            description: "You are on track",
            color: 0xFF9BB167,
          ),
          HealthMetric(
            title: "Activity Level",
            status: "Decent",
            progress: 0.6,
            description: "You are more active than usual",
            color: 0xFFFBBF24,
          ),
          HealthMetric(
            title: "Sleep Level",
            status: "Insomniac",
            progress: 0.2,
            description: "Critical improvement needed",
            color: 0xFFFB7185,
          ),
        ],
        trendData: TrendData(
          currentValue: 87.2,
          changePercentage: -16,
          timeFrame: "Weekly",
          chartData: [85, 88, 92, 89, 87, 85, 87],
        ),
        aiRecommendations: [
          AIRecommendation(
            category: "Hydration",
            title: "Boost Hydration",
            description:
                "Increase your daily water intake by drinking one extra glass of water daily.",
            targetValue: "2,500ml water intake daily",
            scoreIncrease: 2,
            iconPath: "assets/images/water_drop_icon.svg",
          ),
          AIRecommendation(
            category: "Mindfulness Level",
            title: "Do Breathing Exercise",
            description:
                "Increase your daily water intake by drinking one extra glass of water daily.",
            targetValue: "Do 5,000 Steps Daily",
            scoreIncrease: 1,
            iconPath: "assets/images/activity_running_icon.svg",
          ),
          AIRecommendation(
            category: "Sleep",
            title: "Improve Sleep Hygiene",
            description:
                "Increase your daily water intake by drinking one extra glass of water daily.",
            targetValue: "Get 8hr of sleep",
            scoreIncrease: 4,
            iconPath: "assets/images/sleep_zzz_icon.svg",
          ),
        ],
      );

      emit(OmieScoreDetailLoaded(scoreData));
    } catch (e) {
      emit(OmieScoreDetailError('Failed to load score details'));
    }
  }

  /// [_onUpdateSelectedTimeFrame] - Handles updating the selected time frame
  void _onUpdateSelectedTimeFrame(
    UpdateSelectedTimeFrame event,
    Emitter<OmieScoreDetailState> emit,
  ) {
    final currentState = state;
    if (currentState is OmieScoreDetailLoaded) {
      final updatedTrendData = currentState.scoreData.trendData.copyWith(
        timeFrame: event.timeFrame,
      );
      final updatedScoreData = currentState.scoreData.copyWith(
        trendData: updatedTrendData,
      );
      emit(OmieScoreDetailLoaded(updatedScoreData));
    }
  }
}

/// [OmieScoreData] - Data model for Omie Score details
class OmieScoreData extends Equatable {
  final int currentScore;
  final int maxScore;
  final DateTime lastUpdated;
  final String description;
  final List<ScoreBreakdownItem> scoreBreakdown;
  final List<HealthMetric> healthMetrics;
  final TrendData trendData;
  final List<AIRecommendation> aiRecommendations;

  const OmieScoreData({
    required this.currentScore,
    required this.maxScore,
    required this.lastUpdated,
    required this.description,
    required this.scoreBreakdown,
    required this.healthMetrics,
    required this.trendData,
    required this.aiRecommendations,
  });

  OmieScoreData copyWith({
    int? currentScore,
    int? maxScore,
    DateTime? lastUpdated,
    String? description,
    List<ScoreBreakdownItem>? scoreBreakdown,
    List<HealthMetric>? healthMetrics,
    TrendData? trendData,
    List<AIRecommendation>? aiRecommendations,
  }) {
    return OmieScoreData(
      currentScore: currentScore ?? this.currentScore,
      maxScore: maxScore ?? this.maxScore,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      description: description ?? this.description,
      scoreBreakdown: scoreBreakdown ?? this.scoreBreakdown,
      healthMetrics: healthMetrics ?? this.healthMetrics,
      trendData: trendData ?? this.trendData,
      aiRecommendations: aiRecommendations ?? this.aiRecommendations,
    );
  }

  @override
  List<Object> get props => [
        currentScore,
        maxScore,
        lastUpdated,
        description,
        scoreBreakdown,
        healthMetrics,
        trendData,
        aiRecommendations,
      ];
}

/// [ScoreBreakdownItem] - Individual score breakdown item
class ScoreBreakdownItem extends Equatable {
  final String range;
  final String category;
  final int color;

  const ScoreBreakdownItem({
    required this.range,
    required this.category,
    required this.color,
  });

  @override
  List<Object> get props => [range, category, color];
}

/// [HealthMetric] - Individual health metric
class HealthMetric extends Equatable {
  final String title;
  final String status;
  final double progress;
  final String description;
  final int color;

  const HealthMetric({
    required this.title,
    required this.status,
    required this.progress,
    required this.description,
    required this.color,
  });

  @override
  List<Object> get props => [title, status, progress, description, color];
}

/// [TrendData] - Trend chart data
class TrendData extends Equatable {
  final double currentValue;
  final int changePercentage;
  final String timeFrame;
  final List<double> chartData;

  const TrendData({
    required this.currentValue,
    required this.changePercentage,
    required this.timeFrame,
    required this.chartData,
  });

  TrendData copyWith({
    double? currentValue,
    int? changePercentage,
    String? timeFrame,
    List<double>? chartData,
  }) {
    return TrendData(
      currentValue: currentValue ?? this.currentValue,
      changePercentage: changePercentage ?? this.changePercentage,
      timeFrame: timeFrame ?? this.timeFrame,
      chartData: chartData ?? this.chartData,
    );
  }

  @override
  List<Object> get props =>
      [currentValue, changePercentage, timeFrame, chartData];
}

/// [AIRecommendation] - AI recommendation item
class AIRecommendation extends Equatable {
  final String category;
  final String title;
  final String description;
  final String targetValue;
  final int scoreIncrease;
  final String iconPath;

  const AIRecommendation({
    required this.category,
    required this.title,
    required this.description,
    required this.targetValue,
    required this.scoreIncrease,
    required this.iconPath,
  });

  @override
  List<Object> get props => [
        category,
        title,
        description,
        targetValue,
        scoreIncrease,
        iconPath,
      ];
}
