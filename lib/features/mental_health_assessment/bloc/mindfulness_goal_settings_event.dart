part of 'mindfulness_goal_settings_bloc.dart';

/// [MindfulnessGoalSettingsEvent] - Base event class for mindfulness goal settings events
/// Events handle user interactions for goal configuration and reminders
abstract class MindfulnessGoalSettingsEvent extends Equatable {
  const MindfulnessGoalSettingsEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMindfulnessGoalSettings] - Event to initialize the goal settings screen
class LoadMindfulnessGoalSettings extends MindfulnessGoalSettingsEvent {
  const LoadMindfulnessGoalSettings();
}

/// [UpdateGoalTarget] - Event to update the mindfulness goal target
class UpdateGoalTarget extends MindfulnessGoalSettingsEvent {
  final int targetPoints;

  const UpdateGoalTarget(this.targetPoints);

  @override
  List<Object> get props => [targetPoints];
}

/// [UpdateMaintainUntilDate] - Event to update the maintain until date
class UpdateMaintainUntilDate extends MindfulnessGoalSettingsEvent {
  final DateTime maintainUntilDate;

  const UpdateMaintainUntilDate(this.maintainUntilDate);

  @override
  List<Object> get props => [maintainUntilDate];
}

/// [UpdateReminderSchedule] - Event to update the reminder schedule
class UpdateReminderSchedule extends MindfulnessGoalSettingsEvent {
  final String reminderSchedule;

  const UpdateReminderSchedule(this.reminderSchedule);

  @override
  List<Object> get props => [reminderSchedule];
}

/// [EditGoalLevel] - Event to trigger goal level editing
class EditGoalLevel extends MindfulnessGoalSettingsEvent {
  const EditGoalLevel();
}

/// [ViewMaintainUntilSettings] - Event to view maintain until settings
class ViewMaintainUntilSettings extends MindfulnessGoalSettingsEvent {
  const ViewMaintainUntilSettings();
}

/// [ViewReminderSettings] - Event to view reminder settings
class ViewReminderSettings extends MindfulnessGoalSettingsEvent {
  const ViewReminderSettings();
}
