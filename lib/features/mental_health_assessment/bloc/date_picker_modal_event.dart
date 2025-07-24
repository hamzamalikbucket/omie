part of 'date_picker_modal_bloc.dart';

/// [DatePickerModalEvent] - Base event class for date picker modal events
/// Events handle date selection, navigation, and modal interactions
abstract class DatePickerModalEvent extends Equatable {
  const DatePickerModalEvent();

  @override
  List<Object> get props => [];
}

/// [LoadDatePickerModal] - Event to initialize the date picker modal
class LoadDatePickerModal extends DatePickerModalEvent {
  final DateTime? initialDate;

  const LoadDatePickerModal({this.initialDate});
  @override
  List<Object> get props => [initialDate ?? DateTime.now()];
}

/// [SelectDate] - Event to select a specific date
class SelectDate extends DatePickerModalEvent {
  final DateTime selectedDate;

  const SelectDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

/// [NavigateMonth] - Event to navigate to previous or next month
class NavigateMonth extends DatePickerModalEvent {
  final bool isNextMonth;

  const NavigateMonth(this.isNextMonth);

  @override
  List<Object> get props => [isNextMonth];
}

/// [GoToToday] - Event to navigate to today's date
class GoToToday extends DatePickerModalEvent {
  const GoToToday();
}

/// [ConfirmDateSelection] - Event to confirm the selected date
class ConfirmDateSelection extends DatePickerModalEvent {
  const ConfirmDateSelection();
}

/// [CloseModal] - Event to close the date picker modal
class CloseModal extends DatePickerModalEvent {
  const CloseModal();
}
