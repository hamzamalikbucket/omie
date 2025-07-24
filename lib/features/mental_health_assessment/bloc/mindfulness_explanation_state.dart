part of 'mindfulness_explanation_bloc.dart';

/// [MindfulnessExplanationStatus] - Enumeration for different states of the mindfulness explanation
/// Used to manage loading, success, and error states
enum MindfulnessExplanationStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when fetching data
  loading,

  /// Success state when data is loaded successfully
  loaded,

  /// Error state when there's an issue loading data
  error,
}

/// [MeasurementFactor] - Model for how mindfulness is measured
class MeasurementFactor extends Equatable {
  /// [number] - The step number (1, 2, 3)
  final String number;

  /// [title] - The title of the measurement factor
  final String title;

  /// [description] - The description of the measurement factor
  final String description;

  const MeasurementFactor({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [number, title, description];
}

/// [ScoreBreakdown] - Model for score breakdown ranges
class ScoreBreakdown extends Equatable {
  /// [range] - The percentage range (e.g., "0 - 25%")
  final String range;

  /// [iconPath] - Path to the icon asset
  final String iconPath;

  /// [iconColor] - Color for the icon
  final int iconColor;

  /// [backgroundColor] - Background color for the icon container
  final int backgroundColor;

  /// [progressColor] - Color for the progress bars
  final int progressColor;

  /// [progressCount] - Number of filled progress bars (1-4)
  final int progressCount;

  /// [description] - Description of this score range
  final String description;

  const ScoreBreakdown({
    required this.range,
    required this.iconPath,
    required this.iconColor,
    required this.backgroundColor,
    required this.progressColor,
    required this.progressCount,
    required this.description,
  });

  @override
  List<Object> get props => [
        range,
        iconPath,
        iconColor,
        backgroundColor,
        progressColor,
        progressCount,
        description,
      ];
}

/// [MindfulnessExplanationState] - State class containing all mindfulness explanation data
/// Manages score information, measurement factors, and score breakdown data
class MindfulnessExplanationState extends Equatable {
  /// [status] - Current status of the mindfulness explanation screen
  final MindfulnessExplanationStatus status;

  /// [score] - Current mindfulness score (e.g., "88.2")
  final String score;

  /// [statusMessage] - Status message displayed below the score
  final String statusMessage;

  /// [explanation] - Explanation text about mindfulness level
  final String explanation;

  /// [measurementFactors] - List of factors used to measure mindfulness
  final List<MeasurementFactor> measurementFactors;

  /// [scoreBreakdowns] - List of score breakdown ranges
  final List<ScoreBreakdown> scoreBreakdowns;

  /// [currentProgress] - Current user's progress (0.0 to 1.0)
  final double currentProgress;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  const MindfulnessExplanationState({
    this.status = MindfulnessExplanationStatus.initial,
    this.score = '88.2',
    this.statusMessage = 'Somewhat Mindful',
    this.explanation =
        'Mindfulness Level measures how present and focused you are in the current moment. It reflects your ability to stay aware of your thoughts, emotions, and surroundings without getting overwhelmed.',
    this.measurementFactors = const [
      MeasurementFactor(
        number: '1',
        title: 'Mindfulness Activities',
        description:
            'Meditation, breathing exercises, and other guided practices logged i',
      ),
      MeasurementFactor(
        number: '2',
        title: 'Improved Focus',
        description: 'Stay clear and productive throughout your day.',
      ),
      MeasurementFactor(
        number: '3',
        title: 'Calmness and Happiness',
        description: 'We also measure happiness and calmness.',
      ),
    ],
    this.scoreBreakdowns = const [
      ScoreBreakdown(
        range: '0 - 25%',
        iconPath: 'assets/images/heart_icon.svg',
        iconColor: 0xFF926247,
        backgroundColor: 0xFFF7F3EF,
        progressColor: 0xFF926247,
        progressCount: 1,
        description:
            'Feeling overwhelmed, easily distracted, or disconnected from the present moment.',
      ),
      ScoreBreakdown(
        range: '26 - 51%',
        iconPath: 'assets/images/leaf_single_icon.svg',
        iconColor: 0xFFF43F5E,
        backgroundColor: 0xFFFFF1F2,
        progressColor: 0xFFFB7185,
        progressCount: 2,
        description:
            'Occasionally present but frequently pulled away by stress or multitasking.',
      ),
      ScoreBreakdown(
        range: '51 - 74%',
        iconPath: 'assets/images/activity_yoga_icon.svg',
        iconColor: 0xFFF59E0B,
        backgroundColor: 0xFFFFFBEB,
        progressColor: 0xFFFBBF24,
        progressCount: 3,
        description:
            'Staying present for most tasks with moments of distraction.',
      ),
      ScoreBreakdown(
        range: '75 - 100%',
        iconPath: 'assets/images/activity_meditation_icon.svg',
        iconColor: 0xFF7F974B,
        backgroundColor: 0xFFF5F7EE,
        progressColor: 0xFF9BB167,
        progressCount: 4,
        description:
            'Feeling deeply connected, calm, and focused throughout your day.',
      ),
    ],
    this.currentProgress = 0.6,
    this.errorMessage,
  });

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  MindfulnessExplanationState copyWith({
    MindfulnessExplanationStatus? status,
    String? score,
    String? statusMessage,
    String? explanation,
    List<MeasurementFactor>? measurementFactors,
    List<ScoreBreakdown>? scoreBreakdowns,
    double? currentProgress,
    String? errorMessage,
  }) {
    return MindfulnessExplanationState(
      status: status ?? this.status,
      score: score ?? this.score,
      statusMessage: statusMessage ?? this.statusMessage,
      explanation: explanation ?? this.explanation,
      measurementFactors: measurementFactors ?? this.measurementFactors,
      scoreBreakdowns: scoreBreakdowns ?? this.scoreBreakdowns,
      currentProgress: currentProgress ?? this.currentProgress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        score,
        statusMessage,
        explanation,
        measurementFactors,
        scoreBreakdowns,
        currentProgress,
        errorMessage,
      ];
}
