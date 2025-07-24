import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mindfulness_history_event.dart';
part 'mindfulness_history_state.dart';

/// [MindfulnessHistoryBloc] - Business logic component for mindfulness history screen
/// Manages state changes, data loading, filtering, and entry deletion for the history screen
/// Following Apple's Human Interface Guidelines for smooth state transitions and user feedback
class MindfulnessHistoryBloc
    extends Bloc<MindfulnessHistoryEvent, MindfulnessHistoryState> {
  /// Constructor initializes the bloc with initial state and registers event handlers
  MindfulnessHistoryBloc() : super(const MindfulnessHistoryState()) {
    // Register event handlers for different user actions
    on<LoadMindfulnessHistory>(_onLoadMindfulnessHistory);
    on<FilterHistory>(_onFilterHistory);
    on<DeleteHistoryEntry>(_onDeleteHistoryEntry);
    on<RefreshHistory>(_onRefreshHistory);
  }

  /// [_onLoadMindfulnessHistory] - Handles loading initial mindfulness history data
  /// Simulates data fetching and updates state with loaded history entries
  Future<void> _onLoadMindfulnessHistory(
    LoadMindfulnessHistory event,
    Emitter<MindfulnessHistoryState> emit,
  ) async {
    try {
      // [_onLoadMindfulnessHistory] Set loading state
      print('[MindfulnessHistoryBloc] Loading mindfulness history data');
      emit(state.copyWith(status: MindfulnessHistoryStatus.loading));

      // Simulate API call delay for smooth UX
      await Future.delayed(const Duration(milliseconds: 800));

      // [_onLoadMindfulnessHistory] Load data with history entries
      print(
          '[MindfulnessHistoryBloc] Mindfulness history data loaded successfully');
      emit(state.copyWith(
        status: MindfulnessHistoryStatus.loaded,
      ));
    } catch (error) {
      // [_onLoadMindfulnessHistory] Handle error state
      print(
          '[MindfulnessHistoryBloc] Error loading mindfulness history: $error');
      emit(state.copyWith(
        status: MindfulnessHistoryStatus.error,
        errorMessage: 'Failed to load history data. Please try again.',
      ));
    }
  }

  /// [_onFilterHistory] - Handles filtering history entries by criteria
  /// Updates the selected filter and potentially filters the displayed entries
  Future<void> _onFilterHistory(
    FilterHistory event,
    Emitter<MindfulnessHistoryState> emit,
  ) async {
    // [_onFilterHistory] Handle filter selection
    print('[MindfulnessHistoryBloc] Filtering history by: ${event.filterType}');

    // Update selected filter
    emit(state.copyWith(selectedFilter: event.filterType));

    // In a real app, this would filter the data based on the criteria
    // For now, we just update the selected filter state
  }

  /// [_onDeleteHistoryEntry] - Handles deletion of a specific history entry
  /// Removes the entry from the appropriate section and updates the state
  Future<void> _onDeleteHistoryEntry(
    DeleteHistoryEntry event,
    Emitter<MindfulnessHistoryState> emit,
  ) async {
    try {
      // [_onDeleteHistoryEntry] Delete entry from history
      print(
          '[MindfulnessHistoryBloc] Deleting history entry: ${event.entryId}');

      // Create updated sections without the deleted entry
      final updatedSections = state.historySections.map((section) {
        final updatedEntries = section.entries
            .where((entry) => entry.id != event.entryId)
            .toList();

        return HistorySection(
          date: section.date,
          entries: updatedEntries,
        );
      }).toList();

      // Remove empty sections
      final filteredSections = updatedSections
          .where((section) => section.entries.isNotEmpty)
          .toList();

      emit(state.copyWith(historySections: filteredSections));
      print('[MindfulnessHistoryBloc] History entry deleted successfully');
    } catch (error) {
      // [_onDeleteHistoryEntry] Handle error
      print('[MindfulnessHistoryBloc] Error deleting history entry: $error');
      emit(state.copyWith(
        status: MindfulnessHistoryStatus.error,
        errorMessage: 'Failed to delete entry. Please try again.',
      ));
    }
  }

  /// [_onRefreshHistory] - Handles refreshing the history data
  /// Reloads all history entries and updates the state
  Future<void> _onRefreshHistory(
    RefreshHistory event,
    Emitter<MindfulnessHistoryState> emit,
  ) async {
    // [_onRefreshHistory] Refresh history data
    print('[MindfulnessHistoryBloc] Refreshing history data');

    // Trigger a reload of the history data
    add(const LoadMindfulnessHistory());
  }
}
