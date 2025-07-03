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
