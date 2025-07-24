import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mindfulness_goal_settings_event.dart';
part 'mindfulness_goal_settings_state.dart';

/// [MindfulnessGoalSettingsBloc] - Business logic component for mindfulness goal settings screen
/// Manages goal targets, maintenance dates, reminders, and user interactions
/// Following Apple's Human Interface Guidelines for settings and configuration screens
class MindfulnessGoalSettingsBloc
    extends Bloc<MindfulnessGoalSettingsEvent, MindfulnessGoalSettingsState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  MindfulnessGoalSettingsBloc() : super(MindfulnessGoalSettingsState()) {
    // Register event handlers for different user actions
    on<LoadMindfulnessGoalSettings>(_onLoadMindfulnessGoalSettings);
    on<UpdateGoalTarget>(_onUpdateGoalTarget);
    on<UpdateMaintainUntilDate>(_onUpdateMaintainUntilDate);
    on<UpdateReminderSchedule>(_onUpdateReminderSchedule);
    on<EditGoalLevel>(_onEditGoalLevel);
    on<ViewMaintainUntilSettings>(_onViewMaintainUntilSettings);
    on<ViewReminderSettings>(_onViewReminderSettings);
  }

  /// [_onLoadMindfulnessGoalSettings] - Handles loading initial goal settings data
  /// Initializes the settings with default values and prepares for user interaction
  Future<void> _onLoadMindfulnessGoalSettings(
    LoadMindfulnessGoalSettings event,
    Emitter<MindfulnessGoalSettingsState> emit,
  ) async {
    try {
      // [_onLoadMindfulnessGoalSettings] Set loading state
      print('[MindfulnessGoalSettingsBloc] Loading goal settings screen');
      emit(state.copyWith(status: MindfulnessGoalSettingsStatus.loading));

      // Simulate brief loading for smooth UX
      await Future.delayed(const Duration(milliseconds: 300));

      // Update setting items with current state values
      final updatedItems = state.settingItems.map((item) {
        if (item.id == 'maintain_until') {
          return item.copyWith(value: state.formattedMaintainUntilDate);
        } else if (item.id == 'reminder') {
          return item.copyWith(value: state.reminderSchedule);
        }
        return item;
      }).toList();

      // [_onLoadMindfulnessGoalSettings] Set ready state
      print('[MindfulnessGoalSettingsBloc] Goal settings screen ready');
      emit(state.copyWith(
        status: MindfulnessGoalSettingsStatus.ready,
        settingItems: updatedItems,
      ));
    } catch (error) {
      // [_onLoadMindfulnessGoalSettings] Handle error state
      print(
          '[MindfulnessGoalSettingsBloc] Error loading goal settings: $error');
      emit(state.copyWith(
        status: MindfulnessGoalSettingsStatus.error,
        errorMessage: 'Failed to load goal settings. Please try again.',
      ));
    }
  }

  /// [_onUpdateGoalTarget] - Handles updating the goal target points
  /// Updates the daily mindfulness level target
  Future<void> _onUpdateGoalTarget(
    UpdateGoalTarget event,
    Emitter<MindfulnessGoalSettingsState> emit,
  ) async {
    // [_onUpdateGoalTarget] Update goal target
    print(
        '[MindfulnessGoalSettingsBloc] Updating goal target to: ${event.targetPoints}');

    emit(state.copyWith(goalTarget: event.targetPoints));
  }

  /// [_onUpdateMaintainUntilDate] - Handles updating the maintain until date
  /// Updates the date until which the user wants to maintain their goal
  Future<void> _onUpdateMaintainUntilDate(
    UpdateMaintainUntilDate event,
    Emitter<MindfulnessGoalSettingsState> emit,
  ) async {
    // [_onUpdateMaintainUntilDate] Update maintain until date
    print(
        '[MindfulnessGoalSettingsBloc] Updating maintain until date to: ${event.maintainUntilDate}');

    // Update setting items with new date
    final updatedItems = state.settingItems.map((item) {
      if (item.id == 'maintain_until') {
        final newState =
            state.copyWith(maintainUntilDate: event.maintainUntilDate);
        return item.copyWith(value: newState.formattedMaintainUntilDate);
      }
      return item;
    }).toList();

    emit(state.copyWith(
      maintainUntilDate: event.maintainUntilDate,
      settingItems: updatedItems,
    ));
  }

  /// [_onUpdateReminderSchedule] - Handles updating the reminder schedule
  /// Updates when and how often the user wants to be reminded
  Future<void> _onUpdateReminderSchedule(
    UpdateReminderSchedule event,
    Emitter<MindfulnessGoalSettingsState> emit,
  ) async {
    // [_onUpdateReminderSchedule] Update reminder schedule
    print(
        '[MindfulnessGoalSettingsBloc] Updating reminder schedule to: ${event.reminderSchedule}');

    // Update setting items with new schedule
    final updatedItems = state.settingItems.map((item) {
      if (item.id == 'reminder') {
        return item.copyWith(value: event.reminderSchedule);
      }
      return item;
    }).toList();

    emit(state.copyWith(
      reminderSchedule: event.reminderSchedule,
      settingItems: updatedItems,
    ));
  }

  /// [_onEditGoalLevel] - Handles editing the goal level
  /// Triggers the goal level editing flow
  Future<void> _onEditGoalLevel(
    EditGoalLevel event,
    Emitter<MindfulnessGoalSettingsState> emit,
  ) async {
    // [_onEditGoalLevel] Handle goal level editing
    print('[MindfulnessGoalSettingsBloc] Edit goal level requested');

    // This would typically navigate to a goal editing screen
    // For now, we'll just log the action
    print(
        '[MindfulnessGoalSettingsBloc] Current goal target: ${state.goalTarget}');
  }

  /// [_onViewMaintainUntilSettings] - Handles viewing maintain until settings
  /// Shows detailed settings for the maintain until date
  Future<void> _onViewMaintainUntilSettings(
    ViewMaintainUntilSettings event,
    Emitter<MindfulnessGoalSettingsState> emit,
  ) async {
    // [_onViewMaintainUntilSettings] Handle maintain until settings view
    print(
        '[MindfulnessGoalSettingsBloc] View maintain until settings requested');

    // This would typically navigate to a date picker or settings screen
    print(
        '[MindfulnessGoalSettingsBloc] Current maintain until date: ${state.formattedMaintainUntilDate}');
  }

  /// [_onViewReminderSettings] - Handles viewing reminder settings
  /// Shows detailed settings for reminder configuration
  Future<void> _onViewReminderSettings(
    ViewReminderSettings event,
    Emitter<MindfulnessGoalSettingsState> emit,
  ) async {
    // [_onViewReminderSettings] Handle reminder settings view
    print('[MindfulnessGoalSettingsBloc] View reminder settings requested');

    // This would typically navigate to a reminder configuration screen
    print(
        '[MindfulnessGoalSettingsBloc] Current reminder schedule: ${state.reminderSchedule}');
  }
}
