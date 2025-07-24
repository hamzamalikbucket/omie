part of 'mindfulness_logging_bloc.dart';

/// [MindfulnessLoggingStatus] - Enumeration for different states of the logging screen
enum MindfulnessLoggingStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when processing data
  loading,

  /// Ready state when user can interact
  ready,

  /// Submitting state when logging data
  submitting,

  /// Success state when log is submitted
  submitted,

  /// Error state when there's an issue
  error,
}

/// [FeelingOption] - Model for feeling selection options
class FeelingOption extends Equatable {
  /// [id] - Unique identifier for the feeling
  final String id;

  /// [label] - Display label for the feeling
  final String label;

  /// [iconPath] - Path to the icon asset
  final String iconPath;

  /// [isSelected] - Whether this feeling is currently selected
  final bool isSelected;

  /// [color] - Color when selected
  final int color;

  const FeelingOption({
    required this.id,
    required this.label,
    required this.iconPath,
    this.isSelected = false,
    this.color = 0xFFF08C51, // Default orange
  });

  /// [copyWith] - Create a copy with updated fields
  FeelingOption copyWith({
    String? id,
    String? label,
    String? iconPath,
    bool? isSelected,
    int? color,
  }) {
    return FeelingOption(
      id: id ?? this.id,
      label: label ?? this.label,
      iconPath: iconPath ?? this.iconPath,
      isSelected: isSelected ?? this.isSelected,
      color: color ?? this.color,
    );
  }

  @override
  List<Object> get props => [id, label, iconPath, isSelected, color];
}

/// [EmotionOption] - Model for emotion selection options
class EmotionOption extends Equatable {
  /// [id] - Unique identifier for the emotion
  final String id;

  /// [label] - Display label for the emotion
  final String label;

  /// [iconPath] - Path to the icon asset
  final String iconPath;

  /// [isSelected] - Whether this emotion is currently selected
  final bool isSelected;

  const EmotionOption({
    required this.id,
    required this.label,
    required this.iconPath,
    this.isSelected = false,
  });

  /// [copyWith] - Create a copy with updated fields
  EmotionOption copyWith({
    String? id,
    String? label,
    String? iconPath,
    bool? isSelected,
  }) {
    return EmotionOption(
      id: id ?? this.id,
      label: label ?? this.label,
      iconPath: iconPath ?? this.iconPath,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object> get props => [id, label, iconPath, isSelected];
}

/// [MindfulnessLoggingState] - State class containing all mindfulness logging data
/// Manages form inputs, selections, and submission state for the logging interface
class MindfulnessLoggingState extends Equatable {
  /// [status] - Current status of the logging screen
  final MindfulnessLoggingStatus status;

  /// [mindfulnessLevel] - Current mindfulness level (0.0 to 1.0)
  final double mindfulnessLevel;

  /// [mindfulnessPoints] - Display points value (0-100)
  final int mindfulnessPoints;

  /// [feelingOptions] - Available feeling options
  final List<FeelingOption> feelingOptions;

  /// [selectedFeeling] - Currently selected feeling
  final String? selectedFeeling;

  /// [activity] - Current activity input
  final String activity;

  /// [emotionOptions] - Available emotion options
  final List<EmotionOption> emotionOptions;

  /// [selectedEmotion] - Currently selected emotion
  final String? selectedEmotion;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  const MindfulnessLoggingState({
    this.status = MindfulnessLoggingStatus.initial,
    this.mindfulnessLevel = 0.5, // 50%
    this.mindfulnessPoints = 50,
    this.feelingOptions = const [
      FeelingOption(
        id: 'distracted',
        label: 'Distracted',
        iconPath: 'assets/images/exclamation_mark_triangle_icon.svg',
      ),
      FeelingOption(
        id: 'somewhat_present',
        label: 'Somewhat Present',
        iconPath: 'assets/images/leafs_icon.svg',
        isSelected: true,
        color: 0xFFF08C51,
      ),
      FeelingOption(
        id: 'deeply_engaged',
        label: 'Deeply Engaged',
        iconPath: 'assets/images/heart_icon.svg',
      ),
      FeelingOption(
        id: 'fully_present',
        label: 'Fully Present',
        iconPath: 'assets/images/activity_meditation_icon.svg',
      ),
    ],
    this.selectedFeeling = 'somewhat_present',
    this.activity = 'Working',
    this.emotionOptions = const [
      EmotionOption(
        id: 'depressed',
        label: 'Depressed',
        iconPath: 'assets/images/face_depressed_icon.svg',
      ),
      EmotionOption(
        id: 'sad',
        label: 'Sad',
        iconPath: 'assets/images/face_sad_icon.svg',
      ),
      EmotionOption(
        id: 'neutral',
        label: 'Neutral',
        iconPath: 'assets/images/face_neutral_icon.svg',
      ),
      EmotionOption(
        id: 'happy',
        label: 'Happy',
        iconPath: 'assets/images/face_happy_icon.svg',
        isSelected: true,
      ),
      EmotionOption(
        id: 'overjoyed',
        label: 'Overjoyed',
        iconPath: 'assets/images/face_overjoyed_icon.svg',
      ),
    ],
    this.selectedEmotion = 'happy',
    this.errorMessage,
  });

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  MindfulnessLoggingState copyWith({
    MindfulnessLoggingStatus? status,
    double? mindfulnessLevel,
    int? mindfulnessPoints,
    List<FeelingOption>? feelingOptions,
    String? selectedFeeling,
    String? activity,
    List<EmotionOption>? emotionOptions,
    String? selectedEmotion,
    String? errorMessage,
  }) {
    return MindfulnessLoggingState(
      status: status ?? this.status,
      mindfulnessLevel: mindfulnessLevel ?? this.mindfulnessLevel,
      mindfulnessPoints: mindfulnessPoints ?? this.mindfulnessPoints,
      feelingOptions: feelingOptions ?? this.feelingOptions,
      selectedFeeling: selectedFeeling ?? this.selectedFeeling,
      activity: activity ?? this.activity,
      emotionOptions: emotionOptions ?? this.emotionOptions,
      selectedEmotion: selectedEmotion ?? this.selectedEmotion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        mindfulnessLevel,
        mindfulnessPoints,
        feelingOptions,
        selectedFeeling,
        activity,
        emotionOptions,
        selectedEmotion,
        errorMessage,
      ];
}
