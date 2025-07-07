part of 'mental_health_assessment_bloc.dart';

abstract class MentalHealthAssessmentEvent extends Equatable {
  const MentalHealthAssessmentEvent();

  @override
  List<Object> get props => [];
}

class ReadyButtonPressed extends MentalHealthAssessmentEvent {
  const ReadyButtonPressed();
}

class NeedHelpButtonPressed extends MentalHealthAssessmentEvent {
  const NeedHelpButtonPressed();
}

class WeightUnitChanged extends MentalHealthAssessmentEvent {
  const WeightUnitChanged(this.unit);

  final String unit;

  @override
  List<Object> get props => [unit];
}

class WeightValueChanged extends MentalHealthAssessmentEvent {
  const WeightValueChanged(this.weight);

  final int weight;

  @override
  List<Object> get props => [weight];
}

class MentalHealthConditionToggled extends MentalHealthAssessmentEvent {
  const MentalHealthConditionToggled(this.condition);

  final String condition;

  @override
  List<Object> get props => [condition];
}

class SleepLevelChanged extends MentalHealthAssessmentEvent {
  const SleepLevelChanged(this.sleepLevel);

  final int sleepLevel;

  @override
  List<Object> get props => [sleepLevel];
}

class TimeDedicationChanged extends MentalHealthAssessmentEvent {
  const TimeDedicationChanged(this.timeDedication);

  final String timeDedication;

  @override
  List<Object> get props => [timeDedication];
}

class MeditationTimeChanged extends MentalHealthAssessmentEvent {
  const MeditationTimeChanged(this.meditationTime);

  final String meditationTime;

  @override
  List<Object> get props => [meditationTime];
}

class HappinessItemToggled extends MentalHealthAssessmentEvent {
  const HappinessItemToggled(this.item);

  final String item;

  @override
  List<Object> get props => [item];
}

class StressLevelChanged extends MentalHealthAssessmentEvent {
  const StressLevelChanged(this.stressLevel);

  final String stressLevel;

  @override
  List<Object> get props => [stressLevel];
}

/// [AvatarSelected] - Event for when user selects an avatar
class AvatarSelected extends MentalHealthAssessmentEvent {
  const AvatarSelected(this.avatar);

  final String avatar;

  @override
  List<Object> get props => [avatar];
}

/// [MentalHealthAssessmentReUploadImageRequested] - Event for when user wants to re-upload image
class MentalHealthAssessmentReUploadImageRequested
    extends MentalHealthAssessmentEvent {
  const MentalHealthAssessmentReUploadImageRequested();
}

/// [MentalHealthAssessmentNavigateToAvatarSelection] - Event for navigating to avatar selection
class MentalHealthAssessmentNavigateToAvatarSelection
    extends MentalHealthAssessmentEvent {
  const MentalHealthAssessmentNavigateToAvatarSelection();
}
