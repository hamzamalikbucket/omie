part of 'mindfulness_goal_settings_bloc.dart';

/// [MindfulnessGoalSettingsStatus] - Enumeration for different states of the goal settings screen
enum MindfulnessGoalSettingsStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when processing data
  loading,

  /// Ready state when user can interact
  ready,

  /// Error state when there's an issue
  error,
}

/// [GoalSettingItem] - Model for goal setting list items
class GoalSettingItem extends Equatable {
  /// [id] - Unique identifier for the setting
  final String id;

  /// [title] - Display title for the setting
  final String title;

  /// [value] - Current value/status for the setting
  final String value;

  /// [iconPath] - Path to the icon asset
  final String iconPath;

  /// [backgroundColor] - Background color for the icon container
  final int backgroundColor;

  const GoalSettingItem({
    required this.id,
    required this.title,
    required this.value,
    required this.iconPath,
    this.backgroundColor = 0xFFFAFAF9, // Default light gray
  });

  /// [copyWith] - Create a copy with updated fields
  GoalSettingItem copyWith({
    String? id,
    String? title,
    String? value,
    String? iconPath,
    int? backgroundColor,
  }) {
    return GoalSettingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      iconPath: iconPath ?? this.iconPath,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  List<Object> get props => [id, title, value, iconPath, backgroundColor];
}

/// [MindfulnessGoalSettingsState] - State class containing all mindfulness goal settings data
/// Manages goal targets, dates, reminders, and UI configuration
class MindfulnessGoalSettingsState extends Equatable {
  /// [status] - Current status of the goal settings screen
  final MindfulnessGoalSettingsStatus status;

  /// [goalTarget] - Target points for mindfulness level
  final int goalTarget;

  /// [goalDescription] - Description text for the goal
  final String goalDescription;

  /// [goalTitle] - Main title for the goal section
  final String goalTitle;

  /// [maintainUntilDate] - Date until which to maintain the goal
  final DateTime maintainUntilDate;

  /// [reminderSchedule] - Schedule for reminders
  final String reminderSchedule;

  /// [settingItems] - List of configurable setting items
  final List<GoalSettingItem> settingItems;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  MindfulnessGoalSettingsState({
    this.status = MindfulnessGoalSettingsStatus.initial,
    this.goalTarget = 75,
    this.goalDescription = 'pts or more daily',
    this.goalTitle = 'Your mindfulness level goal',
    DateTime? maintainUntilDate,
    this.reminderSchedule = 'Weekly on Mon, Sat',
    List<GoalSettingItem>? settingItems,
    this.errorMessage,
  })  : maintainUntilDate = maintainUntilDate ?? DateTime(2025, 6, 2),
        settingItems = settingItems ??
            const [
              GoalSettingItem(
                id: 'maintain_until',
                title: 'Maintain Until',
                value: 'Jun 2,2025',
                iconPath: 'assets/images/flag_icon.svg',
              ),
              GoalSettingItem(
                id: 'reminder',
                title: 'Reminder',
                value: 'Weekly on Mon, Sat',
                iconPath: 'assets/images/bell_notification_icon.svg',
              ),
            ];

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  MindfulnessGoalSettingsState copyWith({
    MindfulnessGoalSettingsStatus? status,
    int? goalTarget,
    String? goalDescription,
    String? goalTitle,
    DateTime? maintainUntilDate,
    String? reminderSchedule,
    List<GoalSettingItem>? settingItems,
    String? errorMessage,
  }) {
    return MindfulnessGoalSettingsState(
      status: status ?? this.status,
      goalTarget: goalTarget ?? this.goalTarget,
      goalDescription: goalDescription ?? this.goalDescription,
      goalTitle: goalTitle ?? this.goalTitle,
      maintainUntilDate: maintainUntilDate ?? this.maintainUntilDate,
      reminderSchedule: reminderSchedule ?? this.reminderSchedule,
      settingItems: settingItems ?? this.settingItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// [formattedMaintainUntilDate] - Getter for formatted maintain until date
  String get formattedMaintainUntilDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[maintainUntilDate.month - 1]} ${maintainUntilDate.day},${maintainUntilDate.year}';
  }

  @override
  List<Object?> get props => [
        status,
        goalTarget,
        goalDescription,
        goalTitle,
        maintainUntilDate,
        reminderSchedule,
        settingItems,
        errorMessage,
      ];
}
