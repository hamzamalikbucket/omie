part of 'mental_health_assessment_bloc.dart';

enum MentalHealthAssessmentStatus {
  initial,
  navigateToAssessment,
  showHelp,
}

class MentalHealthAssessmentState extends Equatable {
  const MentalHealthAssessmentState({
    this.status = MentalHealthAssessmentStatus.initial,
    this.weightUnit = 'lbs',
    this.weightValue = 140,
    this.selectedConditions = const <String>{},
    this.selectedSleepLevel,
  });

  final MentalHealthAssessmentStatus status;
  final String weightUnit;
  final int weightValue;
  final Set<String> selectedConditions;
  final int? selectedSleepLevel;

  MentalHealthAssessmentState copyWith({
    MentalHealthAssessmentStatus? status,
    String? weightUnit,
    int? weightValue,
    Set<String>? selectedConditions,
    int? selectedSleepLevel,
  }) {
    return MentalHealthAssessmentState(
      status: status ?? this.status,
      weightUnit: weightUnit ?? this.weightUnit,
      weightValue: weightValue ?? this.weightValue,
      selectedConditions: selectedConditions ?? this.selectedConditions,
      selectedSleepLevel: selectedSleepLevel ?? this.selectedSleepLevel,
    );
  }

  @override
  List<Object?> get props =>
      [status, weightUnit, weightValue, selectedConditions, selectedSleepLevel];
}
