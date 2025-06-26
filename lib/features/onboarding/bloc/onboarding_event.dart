import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingNextPressed extends OnboardingEvent {
  const OnboardingNextPressed();
}

class OnboardingPreviousPressed extends OnboardingEvent {
  const OnboardingPreviousPressed();
}

class OnboardingPageChanged extends OnboardingEvent {
  const OnboardingPageChanged(this.pageIndex);

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}

class OnboardingSkipped extends OnboardingEvent {
  const OnboardingSkipped();
}

class OnboardingCompleted extends OnboardingEvent {
  const OnboardingCompleted();
}
