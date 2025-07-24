part of 'mindfulness_history_bloc.dart';

/// [MindfulnessHistoryEvent] - Base event class for mindfulness history events
/// Events handle user interactions and data loading for the history screen
abstract class MindfulnessHistoryEvent extends Equatable {
  const MindfulnessHistoryEvent();

  @override
  List<Object> get props => [];
}

/// [LoadMindfulnessHistory] - Event to load mindfulness history data
/// Triggered when the page is first loaded
class LoadMindfulnessHistory extends MindfulnessHistoryEvent {
  const LoadMindfulnessHistory();
}

/// [FilterHistory] - Event to filter history by date range or criteria
/// Triggered when user taps on filter button
class FilterHistory extends MindfulnessHistoryEvent {
  /// [filterType] - The type of filter to apply
  final String filterType;

  const FilterHistory(this.filterType);

  @override
  List<Object> get props => [filterType];
}

/// [DeleteHistoryEntry] - Event to delete a specific history entry
/// Triggered when user taps on delete button
class DeleteHistoryEntry extends MindfulnessHistoryEvent {
  /// [entryId] - The ID of the entry to delete
  final String entryId;

  const DeleteHistoryEntry(this.entryId);

  @override
  List<Object> get props => [entryId];
}

/// [RefreshHistory] - Event to refresh the history data
/// Triggered when user pulls to refresh or wants to reload data
class RefreshHistory extends MindfulnessHistoryEvent {
  const RefreshHistory();
}
