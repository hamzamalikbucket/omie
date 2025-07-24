part of 'mindfulness_logging_bloc.dart';

/// [MindfulnessLoggingEvent] - Base event class for mindfulness logging events
/// Events handle user interactions for logging mindfulness data
abstract class MindfulnessLoggingEvent extends Equatable {
  const MindfulnessLoggingEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMindfulnessLogging] - Event to initialize the logging screen
class LoadMindfulnessLogging extends MindfulnessLoggingEvent {
  const LoadMindfulnessLogging();
}

/// [UpdateMindfulnessLevel] - Event to update the mindfulness level slider
class UpdateMindfulnessLevel extends MindfulnessLoggingEvent {
  final double level;

  const UpdateMindfulnessLevel(this.level);

  @override
  List<Object> get props => [level];
}

/// [SelectFeeling] - Event to select how the user feels
class SelectFeeling extends MindfulnessLoggingEvent {
  final String feeling;

  const SelectFeeling(this.feeling);

  @override
  List<Object> get props => [feeling];
}

/// [UpdateActivity] - Event to update what the user was doing
class UpdateActivity extends MindfulnessLoggingEvent {
  final String activity;

  const UpdateActivity(this.activity);

  @override
  List<Object> get props => [activity];
}

/// [SelectEmotion] - Event to select the user's emotion
class SelectEmotion extends MindfulnessLoggingEvent {
  final String emotion;

  const SelectEmotion(this.emotion);

  @override
  List<Object> get props => [emotion];
}

/// [SubmitMindfulnessLog] - Event to submit the mindfulness log
class SubmitMindfulnessLog extends MindfulnessLoggingEvent {
  const SubmitMindfulnessLog();
}
