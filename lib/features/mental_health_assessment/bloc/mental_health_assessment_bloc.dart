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
    on<TimeDedicationChanged>(_onTimeDedicationChanged);
    on<MeditationTimeChanged>(_onMeditationTimeChanged);
    on<HappinessItemToggled>(_onHappinessItemToggled);
    on<StressLevelChanged>(_onStressLevelChanged);
    on<AvatarSelected>(_onAvatarSelected);
    on<MentalHealthAssessmentReUploadImageRequested>(_onReUploadImageRequested);
    on<MentalHealthAssessmentNavigateToAvatarSelection>(
        _onNavigateToAvatarSelection);
  }

  void _onReadyButtonPressed(

    ReadyButtonPressed event, Emitter<MentalHealthAssessmentState> emit) {
    emit(state.copyWith(
    status: MentalHealthAssessmentStatus.navigateToAssessment));
    emit(state.copyWith(
    status: MentalHealthAssessmentStatus.initial));


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

  void _onTimeDedicationChanged(
      TimeDedicationChanged event, Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Update selected time dedication
    emit(state.copyWith(selectedTimeDedication: event.timeDedication));
  }

  void _onMeditationTimeChanged(
      MeditationTimeChanged event, Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Update selected meditation time
    emit(state.copyWith(selectedMeditationTime: event.meditationTime));
  }

  void _onHappinessItemToggled(
      HappinessItemToggled event, Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Toggle happiness item selection
    final currentItems = Set<String>.from(state.selectedHappinessItems);
    if (currentItems.contains(event.item)) {
      currentItems.remove(event.item);
    } else {
      currentItems.add(event.item);
    }
    emit(state.copyWith(selectedHappinessItems: currentItems));
  }

  void _onStressLevelChanged(
      StressLevelChanged event, Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Update selected stress level
    emit(state.copyWith(selectedStressLevel: event.stressLevel));
  }

  void _onAvatarSelected(
      AvatarSelected event, Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Update selected avatar
    emit(state.copyWith(selectedAvatar: event.avatar));
  }

  void _onReUploadImageRequested(
      MentalHealthAssessmentReUploadImageRequested event,
      Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Handle re-upload image request
    emit(state.copyWith(
        status: MentalHealthAssessmentStatus.navigateToImageUpload));
  }

  void _onNavigateToAvatarSelection(
      MentalHealthAssessmentNavigateToAvatarSelection event,
      Emitter<MentalHealthAssessmentState> emit) {
    // [MentalHealthAssessmentBloc] Navigate to avatar selection page
    emit(state.copyWith(
        status: MentalHealthAssessmentStatus.navigateToAvatarSelection));
  }
}
