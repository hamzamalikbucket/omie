import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_picker_modal_event.dart';
part 'date_picker_modal_state.dart';

/// [DatePickerModalBloc] - Business logic component for date picker modal screen
/// Manages date selection, month navigation, calendar generation, and modal interactions
/// Following Apple's Human Interface Guidelines for date picker interfaces
class DatePickerModalBloc
    extends Bloc<DatePickerModalEvent, DatePickerModalState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  DatePickerModalBloc() : super(DatePickerModalState()) {
    // Register event handlers for different user actions
    on<LoadDatePickerModal>(_onLoadDatePickerModal);
    on<SelectDate>(_onSelectDate);
    on<NavigateMonth>(_onNavigateMonth);
    on<GoToToday>(_onGoToToday);
    on<ConfirmDateSelection>(_onConfirmDateSelection);
    on<CloseModal>(_onCloseModal);
  }

  /// [_onLoadDatePickerModal] - Handles loading initial date picker modal data
  /// Initializes the calendar with current month and optional initial date
  Future<void> _onLoadDatePickerModal(
    LoadDatePickerModal event,
    Emitter<DatePickerModalState> emit,
  ) async {
    try {
      // [_onLoadDatePickerModal] Set loading state
      print('[DatePickerModalBloc] Loading date picker modal');
      emit(state.copyWith(status: DatePickerModalStatus.loading));

      // Simulate brief loading for smooth UX
      await Future.delayed(const Duration(milliseconds: 200));

      // Set initial date if provided, otherwise default to 30 days from now
      final initialDate =
          event.initialDate ?? DateTime.now().add(const Duration(days: 30));

      // Generate calendar dates for the initial month
      final calendarDates = _generateCalendarDatesWithSelection(
        initialDate,
        initialDate,
      );

      // [_onLoadDatePickerModal] Set ready state
      print('[DatePickerModalBloc] Date picker modal ready');
      emit(state.copyWith(
        status: DatePickerModalStatus.ready,
        currentMonth: DateTime(initialDate.year, initialDate.month, 1),
        selectedDate: initialDate,
        calendarDates: calendarDates,
        deadlineText: 'Your deadline is ${state.daysUntilDeadline}d from now',
      ));
    } catch (error) {
      // [_onLoadDatePickerModal] Handle error state
      print('[DatePickerModalBloc] Error loading date picker modal: $error');
      emit(state.copyWith(
        status: DatePickerModalStatus.error,
        errorMessage: 'Failed to load date picker. Please try again.',
      ));
    }
  }

  /// [_onSelectDate] - Handles selecting a specific date
  /// Updates the selected date and recalculates deadline text
  Future<void> _onSelectDate(
    SelectDate event,
    Emitter<DatePickerModalState> emit,
  ) async {
    // [_onSelectDate] Update selected date
    print('[DatePickerModalBloc] Selecting date: ${event.selectedDate}');

    // Generate new calendar dates with the selected date highlighted
    final calendarDates = _generateCalendarDatesWithSelection(
      state.currentMonth,
      event.selectedDate,
    );

    // Calculate days until deadline
    final now = DateTime.now();
    final difference = event.selectedDate.difference(now);
    final daysUntilDeadline = difference.inDays;

    emit(state.copyWith(
      selectedDate: event.selectedDate,
      calendarDates: calendarDates,
      deadlineText: 'Your deadline is ${daysUntilDeadline}d from now',
    ));
  }

  /// [_onNavigateMonth] - Handles navigating to previous or next month
  /// Updates the current month and regenerates calendar dates
  Future<void> _onNavigateMonth(
    NavigateMonth event,
    Emitter<DatePickerModalState> emit,
  ) async {
    // [_onNavigateMonth] Navigate to previous or next month
    print(
        '[DatePickerModalBloc] Navigating month: ${event.isNextMonth ? 'next' : 'previous'}');

    final newMonth = event.isNextMonth
        ? DateTime(state.currentMonth.year, state.currentMonth.month + 1, 1)
        : DateTime(state.currentMonth.year, state.currentMonth.month - 1, 1);

    // Generate new calendar dates for the new month
    final calendarDates = _generateCalendarDatesWithSelection(
      newMonth,
      state.selectedDate,
    );

    emit(state.copyWith(
      currentMonth: newMonth,
      calendarDates: calendarDates,
    ));
  }

  /// [_onGoToToday] - Handles navigating to today's date
  /// Updates the current month to today's month and selects today's date
  Future<void> _onGoToToday(
    GoToToday event,
    Emitter<DatePickerModalState> emit,
  ) async {
    // [_onGoToToday] Navigate to today
    print('[DatePickerModalBloc] Going to today');

    final today = DateTime.now();
    final todayMonth = DateTime(today.year, today.month, 1);

    // Generate new calendar dates with today selected
    final calendarDates = _generateCalendarDatesWithSelection(
      todayMonth,
      today,
    );

    emit(state.copyWith(
      currentMonth: todayMonth,
      selectedDate: today,
      calendarDates: calendarDates,
      deadlineText: 'Your deadline is 0d from now',
    ));
  }

  /// [_onConfirmDateSelection] - Handles confirming the selected date
  /// This would typically close the modal and return the selected date
  Future<void> _onConfirmDateSelection(
    ConfirmDateSelection event,
    Emitter<DatePickerModalState> emit,
  ) async {
    // [_onConfirmDateSelection] Confirm date selection
    print(
        '[DatePickerModalBloc] Confirming date selection: ${state.selectedDate}');

    if (state.selectedDate != null) {
      // This would typically navigate back or close the modal
      // For now, we'll just log the confirmation
      print('[DatePickerModalBloc] Date confirmed: ${state.selectedDate}');
    }
  }

  /// [_onCloseModal] - Handles closing the date picker modal
  /// This would typically navigate back without saving changes
  Future<void> _onCloseModal(
    CloseModal event,
    Emitter<DatePickerModalState> emit,
  ) async {
    // [_onCloseModal] Close modal
    print('[DatePickerModalBloc] Closing modal');

    // This would typically navigate back
    // For now, we'll just log the action
    print('[DatePickerModalBloc] Modal closed');
  }

  /// [_generateCalendarDatesWithSelection] - Generate calendar dates with selected date highlighted
  /// Helper method to create calendar grid with proper selection state
  List<CalendarDate> _generateCalendarDatesWithSelection(
      DateTime month, DateTime? selectedDate) {
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
      final isSelected = selectedDate != null &&
          selectedDate.year == date.year &&
          selectedDate.month == date.month &&
          selectedDate.day == date.day;

      dates.add(CalendarDate(
        day: day,
        isCurrentMonth: true,
        isToday: date.year == today.year &&
            date.month == today.month &&
            date.day == today.day,
        isSelected: isSelected,
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
}
