import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingNextPressed>(_onNextPressed);
    on<OnboardingPreviousPressed>(_onPreviousPressed);
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingSkipped>(_onSkipped);
    on<OnboardingCompleted>(_onCompleted);
  }

  void _onNextPressed(
    OnboardingNextPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (!state.isLastPage) {
      emit(state.copyWith(
        currentPageIndex: state.currentPageIndex + 1,
        status: OnboardingStatus.navigating,
      ));
    } else {
      emit(state.copyWith(status: OnboardingStatus.completed));
    }
  }

  void _onPreviousPressed(
    OnboardingPreviousPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (!state.isFirstPage) {
      emit(state.copyWith(
        currentPageIndex: state.currentPageIndex - 1,
        status: OnboardingStatus.navigating,
      ));
    }
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(
      currentPageIndex: event.pageIndex,
      status: OnboardingStatus.navigating,
    ));
  }

  void _onSkipped(
    OnboardingSkipped event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(status: OnboardingStatus.completed));
  }

  void _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(status: OnboardingStatus.completed));
  }
}
