part of 'date_picker_modal_bloc.dart';

/// [DatePickerModalStatus] - Enumeration for different states of the date picker modal
enum DatePickerModalStatus {
  /// Initial state when the modal is first created
  initial,

  /// Loading state when processing data
  loading,

  /// Ready state when user can interact
  ready,

  /// Error state when there's an issue
  error,
}

/// [CalendarDate] - Model for calendar date cells
class CalendarDate extends Equatable {
  /// [day] - Day of the month
  final int day;

  /// [isSelected] - Whether this date is currently selected
  final bool isSelected;

  /// [isCurrentMonth] - Whether this date belongs to the current month
  final bool isCurrentMonth;

  /// [isToday] - Whether this date is today
  final bool isToday;

  const CalendarDate({
    required this.day,
    this.isSelected = false,
    this.isCurrentMonth = true,
    this.isToday = false,
  });

  /// [copyWith] - Create a copy with updated fields
  CalendarDate copyWith({
    int? day,
    bool? isSelected,
    bool? isCurrentMonth,
    bool? isToday,
  }) {
    return CalendarDate(
      day: day ?? this.day,
      isSelected: isSelected ?? this.isSelected,
      isCurrentMonth: isCurrentMonth ?? this.isCurrentMonth,
      isToday: isToday ?? this.isToday,
    );
  }

  @override
  List<Object> get props => [day, isSelected, isCurrentMonth, isToday];
}

/// [DatePickerModalState] - State class containing all date picker modal data
/// Manages current month, selected date, calendar grid, and UI configuration
class DatePickerModalState extends Equatable {
  /// [status] - Current status of the date picker modal
  final DatePickerModalStatus status;

  /// [currentMonth] - Currently displayed month
  final DateTime currentMonth;

  /// [selectedDate] - Currently selected date
  final DateTime? selectedDate;

  /// [calendarDates] - Calendar grid dates for the current month
  final List<CalendarDate> calendarDates;

  /// [title] - Modal title
  final String title;

  /// [deadlineText] - Text showing days until deadline
  final String deadlineText;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  DatePickerModalState({
    this.status = DatePickerModalStatus.initial,
    DateTime? currentMonth,
    this.selectedDate,
    List<CalendarDate>? calendarDates,
    this.title = 'Maintain goal until',
    this.deadlineText = 'Your deadline is 30d from now',
    this.errorMessage,
  })  : currentMonth = currentMonth ?? DateTime.now(),
        calendarDates = calendarDates ??
            _generateCalendarDates(currentMonth ?? DateTime.now());

  /// [_generateCalendarDates] - Generate calendar dates for a given month
  static List<CalendarDate> _generateCalendarDates(DateTime month) {
    final dates = <CalendarDate>[];
    final today = DateTime.now();

    // Get first day of month and last day of month
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    // Get the day of week for first day (0 = Sunday, 1 = Monday, etc.)
    final firstDayWeekday =
        firstDayOfMonth.weekday % 7; // Convert to Sunday = 0

    // Add previous month's days to fill first week
    final previousMonth = DateTime(month.year, month.month - 1, 0);
    for (int i = firstDayWeekday - 1; i >= 0; i--) {
      final day = previousMonth.day - i;
      dates.add(CalendarDate(
        day: day,
        isCurrentMonth: false,
        isToday: false,
      ));
    }

    // Add current month's days
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(month.year, month.month, day);
      dates.add(CalendarDate(
        day: day,
        isCurrentMonth: true,
        isToday: date.year == today.year &&
            date.month == today.month &&
            date.day == today.day,
      ));
    }

    // Add next month's days to fill last week
    final remainingDays = 42 - dates.length; // 6 weeks * 7 days = 42
    for (int day = 1; day <= remainingDays; day++) {
      dates.add(CalendarDate(
        day: day,
        isCurrentMonth: false,
        isToday: false,
      ));
    }

    return dates;
  }

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  DatePickerModalState copyWith({
    DatePickerModalStatus? status,
    DateTime? currentMonth,
    DateTime? selectedDate,
    List<CalendarDate>? calendarDates,
    String? title,
    String? deadlineText,
    String? errorMessage,
  }) {
    return DatePickerModalState(
      status: status ?? this.status,
      currentMonth: currentMonth ?? this.currentMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      calendarDates: calendarDates ?? this.calendarDates,
      title: title ?? this.title,
      deadlineText: deadlineText ?? this.deadlineText,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// [formattedMonthYear] - Getter for formatted month and year
  String get formattedMonthYear {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[currentMonth.month - 1]} ${currentMonth.year}';
  }

  /// [daysUntilDeadline] - Calculate days until the selected deadline
  int get daysUntilDeadline {
    if (selectedDate == null) return 30; // Default
    final now = DateTime.now();
    final difference = selectedDate!.difference(now);
    return difference.inDays;
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
        selectedDate,
        calendarDates,
        title,
        deadlineText,
        errorMessage,
      ];
}
