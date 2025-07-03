import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mental_health_assessment_event.dart';
part 'mental_health_assessment_state.dart';

class MentalHealthAssessmentBloc
    extends Bloc<MentalHealthAssessmentEvent, MentalHealthAssessmentState> {
  MentalHealthAssessmentBloc() : super(const MentalHealthAssessmentState()) {
    on<ReadyButtonPressed>(_onReadyButtonPressed);
    on<NeedHelpButtonPressed>(_onNeedHelpButtonPressed);
    on<WeightUnitChanged>(_onWeightUnitChanged);
    on<WeightValueChanged>(_onWeightValueChanged);
    on<MentalHealthConditionToggled>(_onMentalHealthConditionToggled);
    on<SleepLevelChanged>(_onSleepLevelChanged);
  }

  void _onReadyButtonPressed(
      ReadyButtonPressed event, Emitter<MentalHealthAssessmentState> emit) {
    emit(state.copyWith(
        status: MentalHealthAssessmentStatus.navigateToAssessment));
  }

  void _onNeedHelpButtonPressed(
      NeedHelpButtonPressed event, Emitter<MentalHealthAssessmentState> emit) {
    emit(state.copyWith(status: MentalHealthAssessmentStatus.showHelp));
  }

  void _onWeightUnitChanged(
      WeightUnitChanged event, Emitter<MentalHealthAssessmentState> emit) {
    emit(state.copyWith(weightUnit: event.unit));
  }

  void _onWeightValueChanged(
      WeightValueChanged event, Emitter<MentalHealthAssessmentState> emit) {
    emit(state.copyWith(weightValue: event.weight));
  }

  void _onMentalHealthConditionToggled(MentalHealthConditionToggled event,
      Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Toggle mental health condition selection
    final currentConditions = Set<String>.from(state.selectedConditions);
    if (currentConditions.contains(event.condition)) {
      currentConditions.remove(event.condition);
    } else {
      currentConditions.add(event.condition);
    }
    emit(state.copyWith(selectedConditions: currentConditions));
  }

  void _onSleepLevelChanged(
      SleepLevelChanged event, Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Update selected sleep level
    emit(state.copyWith(selectedSleepLevel: event.sleepLevel));
  }
}
