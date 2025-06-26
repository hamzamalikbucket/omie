import 'package:equatable/equatable.dart';

enum OnboardingStatus { initial, navigating, completed }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.currentPageIndex = 0,
    this.totalPages = 5,
  });

  final OnboardingStatus status;
  final int currentPageIndex;
  final int totalPages;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? currentPageIndex,
    int? totalPages,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  bool get isFirstPage => currentPageIndex == 0;
  bool get isLastPage => currentPageIndex == totalPages - 1;

  @override
  List<Object> get props => [status, currentPageIndex, totalPages];
}
