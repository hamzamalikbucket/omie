part of 'mental_health_assessment_bloc.dart';

enum MentalHealthAssessmentStatus {
  initial,
  navigateToAssessment,
  showHelp,
  navigateToImageUpload,
  navigateToAvatarSelection,
}

class MentalHealthAssessmentState extends Equatable {
  const MentalHealthAssessmentState({
    this.status = MentalHealthAssessmentStatus.initial,
    this.weightUnit = 'lbs',
    this.weightValue = 140,
    this.selectedConditions = const <String>{},
    this.selectedSleepLevel,
    this.selectedTimeDedication,
    this.selectedMeditationTime,
    this.selectedHappinessItems = const <String>{},
    this.selectedStressLevel,
    this.selectedAvatar =
        'avatar_male_profile_2.svg', // Default selected avatar
  });

  final MentalHealthAssessmentStatus status;
  final String weightUnit;
  final int weightValue;
  final Set<String> selectedConditions;
  final int? selectedSleepLevel;
  final String? selectedTimeDedication;
  final String? selectedMeditationTime;
  final Set<String> selectedHappinessItems;
  final String? selectedStressLevel;
  final String selectedAvatar; // Selected avatar filename

  MentalHealthAssessmentState copyWith({
    MentalHealthAssessmentStatus? status,
    String? weightUnit,
    int? weightValue,
    Set<String>? selectedConditions,
    int? selectedSleepLevel,
    String? selectedTimeDedication,
    String? selectedMeditationTime,
    Set<String>? selectedHappinessItems,
    String? selectedStressLevel,
    String? selectedAvatar,
  }) {
    return MentalHealthAssessmentState(
      status: status ?? this.status,
      weightUnit: weightUnit ?? this.weightUnit,
      weightValue: weightValue ?? this.weightValue,
      selectedConditions: selectedConditions ?? this.selectedConditions,
      selectedSleepLevel: selectedSleepLevel ?? this.selectedSleepLevel,
      selectedTimeDedication:
          selectedTimeDedication ?? this.selectedTimeDedication,
      selectedMeditationTime:
          selectedMeditationTime ?? this.selectedMeditationTime,
      selectedHappinessItems:
          selectedHappinessItems ?? this.selectedHappinessItems,
      selectedStressLevel: selectedStressLevel ?? this.selectedStressLevel,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weightUnit,
        weightValue,
        selectedConditions,
        selectedSleepLevel,
        selectedTimeDedication,
        selectedMeditationTime,
        selectedHappinessItems,
        selectedStressLevel,
        selectedAvatar,
      ];
}
