part of 'mindfulness_history_bloc.dart';

/// [MindfulnessHistoryStatus] - Enumeration for different states of the mindfulness history
/// Used to manage loading, success, and error states
enum MindfulnessHistoryStatus {
  /// Initial state when the page is first created
  initial,

  /// Loading state when fetching data
  loading,

  /// Success state when data is loaded successfully
  loaded,

  /// Error state when there's an issue loading data
  error,
}

/// [HistoryEntry] - Model for individual mindfulness history entries
class HistoryEntry extends Equatable {
  /// [id] - Unique identifier for the entry
  final String id;

  /// [score] - The mindfulness score (e.g., "61 pts")
  final String score;

  /// [status] - The mindfulness status (e.g., "Mindful Enough")
  final String status;

  /// [time] - The time the entry was recorded
  final String time;

  /// [hasStatusMessage] - Whether this entry has a special status message
  final bool hasStatusMessage;

  /// [statusMessage] - Optional status message text
  final String? statusMessage;

  /// [isDeletable] - Whether this entry can be deleted
  final bool isDeletable;

  const HistoryEntry({
    required this.id,
    required this.score,
    required this.status,
    required this.time,
    this.hasStatusMessage = false,
    this.statusMessage,
    this.isDeletable = false,
  });

  @override
  List<Object?> get props => [
        id,
        score,
        status,
        time,
        hasStatusMessage,
        statusMessage,
        isDeletable,
      ];
}

/// [HistorySection] - Model for date-organized history sections
class HistorySection extends Equatable {
  /// [date] - The date label for this section (e.g., "Today", "Jan 12, 2026")
  final String date;

  /// [entries] - List of history entries for this date
  final List<HistoryEntry> entries;

  const HistorySection({
    required this.date,
    required this.entries,
  });

  @override
  List<Object> get props => [date, entries];
}

/// [MindfulnessHistoryState] - State class containing all mindfulness history data
/// Manages history entries, sections, filter status, and loading states
class MindfulnessHistoryState extends Equatable {
  /// [status] - Current status of the mindfulness history screen
  final MindfulnessHistoryStatus status;

  /// [description] - Description text shown at the top
  final String description;

  /// [historySections] - List of date-organized history sections
  final List<HistorySection> historySections;

  /// [selectedFilter] - Currently selected filter type
  final String selectedFilter;

  /// [errorMessage] - Error message when status is error
  final String? errorMessage;

  const MindfulnessHistoryState({
    this.status = MindfulnessHistoryStatus.initial,
    this.description = 'Check your mindfulness level history in here.',
    this.historySections = const [
      HistorySection(
        date: 'Today',
        entries: [
          HistoryEntry(
            id: '1',
            score: '61 pts',
            status: 'Mindful Enough',
            time: '10:02AM',
          ),
          HistoryEntry(
            id: '2',
            score: '61 pts',
            status: 'Mindful Enough',
            time: '10:02AM',
            isDeletable: true,
          ),
          HistoryEntry(
            id: '3',
            score: '61 pts',
            status: 'Mindful Enough',
            time: '10:02AM',
            hasStatusMessage: true,
            statusMessage: 'You\'re more mindful.',
          ),
        ],
      ),
      HistorySection(
        date: 'Jan 12, 2026',
        entries: [
          HistoryEntry(
            id: '4',
            score: '61 pts',
            status: 'Mindful Enough',
            time: '10:02AM',
          ),
          HistoryEntry(
            id: '5',
            score: '61 pts',
            status: 'Mindful Enough',
            time: '10:02AM',
          ),
          HistoryEntry(
            id: '6',
            score: '61 pts',
            status: 'Mindful Enough',
            time: '10:02AM',
          ),
        ],
      ),
    ],
    this.selectedFilter = 'All',
    this.errorMessage,
  });

  /// [copyWith] - Method to create a new state with updated values
  /// Used by the Bloc to emit new states while preserving unchanged properties
  MindfulnessHistoryState copyWith({
    MindfulnessHistoryStatus? status,
    String? description,
    List<HistorySection>? historySections,
    String? selectedFilter,
    String? errorMessage,
  }) {
    return MindfulnessHistoryState(
      status: status ?? this.status,
      description: description ?? this.description,
      historySections: historySections ?? this.historySections,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        description,
        historySections,
        selectedFilter,
        errorMessage,
      ];
}
