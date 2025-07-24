import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mindfulness_logging_event.dart';
part 'mindfulness_logging_state.dart';

/// [MindfulnessLoggingBloc] - Business logic component for mindfulness logging screen
/// Manages form state, user selections, and data submission for comprehensive mindfulness tracking
/// Following Apple's Human Interface Guidelines for intuitive form interactions
class MindfulnessLoggingBloc
    extends Bloc<MindfulnessLoggingEvent, MindfulnessLoggingState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  MindfulnessLoggingBloc() : super(const MindfulnessLoggingState()) {
    // Register event handlers for different user actions
    on<LoadMindfulnessLogging>(_onLoadMindfulnessLogging);
    on<UpdateMindfulnessLevel>(_onUpdateMindfulnessLevel);
    on<SelectFeeling>(_onSelectFeeling);
    on<UpdateActivity>(_onUpdateActivity);
    on<SelectEmotion>(_onSelectEmotion);
    on<SubmitMindfulnessLog>(_onSubmitMindfulnessLog);
  }

  /// [_onLoadMindfulnessLogging] - Handles loading initial mindfulness logging data
  /// Initializes the form with default values and prepares for user interaction
  Future<void> _onLoadMindfulnessLogging(
    LoadMindfulnessLogging event,
    Emitter<MindfulnessLoggingState> emit,
  ) async {
    try {
      // [_onLoadMindfulnessLogging] Set loading state
      print('[MindfulnessLoggingBloc] Loading mindfulness logging screen');
      emit(state.copyWith(status: MindfulnessLoggingStatus.loading));

      // Simulate brief loading for smooth UX
      await Future.delayed(const Duration(milliseconds: 300));

      // [_onLoadMindfulnessLogging] Set ready state
      print('[MindfulnessLoggingBloc] Mindfulness logging screen ready');
      emit(state.copyWith(status: MindfulnessLoggingStatus.ready));
    } catch (error) {
      // [_onLoadMindfulnessLogging] Handle error state
      print(
          '[MindfulnessLoggingBloc] Error loading mindfulness logging: $error');
      emit(state.copyWith(
        status: MindfulnessLoggingStatus.error,
        errorMessage: 'Failed to load logging screen. Please try again.',
      ));
    }
  }

  /// [_onUpdateMindfulnessLevel] - Handles updating the mindfulness level slider
  /// Updates both the raw level (0.0-1.0) and display points (0-100)
  Future<void> _onUpdateMindfulnessLevel(
    UpdateMindfulnessLevel event,
    Emitter<MindfulnessLoggingState> emit,
  ) async {
    // [_onUpdateMindfulnessLevel] Update mindfulness level
    print(
        '[MindfulnessLoggingBloc] Updating mindfulness level to: ${event.level}');

    final points = (event.level * 100).round();
    emit(state.copyWith(
      mindfulnessLevel: event.level,
      mindfulnessPoints: points,
    ));
  }

  /// [_onSelectFeeling] - Handles selecting how the user feels
  /// Updates the feeling options to reflect the new selection
  Future<void> _onSelectFeeling(
    SelectFeeling event,
    Emitter<MindfulnessLoggingState> emit,
  ) async {
    // [_onSelectFeeling] Update selected feeling
    print('[MindfulnessLoggingBloc] Selecting feeling: ${event.feeling}');

    // Update feeling options with new selection
    final updatedOptions = state.feelingOptions.map((option) {
      return option.copyWith(isSelected: option.id == event.feeling);
    }).toList();

    emit(state.copyWith(
      selectedFeeling: event.feeling,
      feelingOptions: updatedOptions,
    ));
  }

  /// [_onUpdateActivity] - Handles updating the activity input
  /// Updates what the user was doing during their mindfulness assessment
  Future<void> _onUpdateActivity(
    UpdateActivity event,
    Emitter<MindfulnessLoggingState> emit,
  ) async {
    // [_onUpdateActivity] Update activity
    print('[MindfulnessLoggingBloc] Updating activity to: ${event.activity}');

    emit(state.copyWith(activity: event.activity));
  }

  /// [_onSelectEmotion] - Handles selecting the user's emotion
  /// Updates the emotion options to reflect the new selection
  Future<void> _onSelectEmotion(
    SelectEmotion event,
    Emitter<MindfulnessLoggingState> emit,
  ) async {
    // [_onSelectEmotion] Update selected emotion
    print('[MindfulnessLoggingBloc] Selecting emotion: ${event.emotion}');

    // Update emotion options with new selection
    final updatedOptions = state.emotionOptions.map((option) {
      return option.copyWith(isSelected: option.id == event.emotion);
    }).toList();

    emit(state.copyWith(
      selectedEmotion: event.emotion,
      emotionOptions: updatedOptions,
    ));
  }

  /// [_onSubmitMindfulnessLog] - Handles submitting the mindfulness log
  /// Validates and submits the complete mindfulness data
  Future<void> _onSubmitMindfulnessLog(
    SubmitMindfulnessLog event,
    Emitter<MindfulnessLoggingState> emit,
  ) async {
    try {
      // [_onSubmitMindfulnessLog] Set submitting state
      print('[MindfulnessLoggingBloc] Submitting mindfulness log');
      emit(state.copyWith(status: MindfulnessLoggingStatus.submitting));

      // Simulate API submission
      await Future.delayed(const Duration(milliseconds: 1500));

      // [_onSubmitMindfulnessLog] Log submitted successfully
      print('[MindfulnessLoggingBloc] Mindfulness log submitted successfully');
      print('[MindfulnessLoggingBloc] Level: ${state.mindfulnessPoints}');
      print('[MindfulnessLoggingBloc] Feeling: ${state.selectedFeeling}');
      print('[MindfulnessLoggingBloc] Activity: ${state.activity}');
      print('[MindfulnessLoggingBloc] Emotion: ${state.selectedEmotion}');

      emit(state.copyWith(status: MindfulnessLoggingStatus.submitted));
    } catch (error) {
      // [_onSubmitMindfulnessLog] Handle submission error
      print(
          '[MindfulnessLoggingBloc] Error submitting mindfulness log: $error');
      emit(state.copyWith(
        status: MindfulnessLoggingStatus.error,
        errorMessage: 'Failed to submit log. Please try again.',
      ));
    }
  }
}
