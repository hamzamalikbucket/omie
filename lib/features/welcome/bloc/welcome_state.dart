part of 'welcome_bloc.dart';

enum WelcomeStatus { initial, navigatingToHome, navigatingToSignIn }

class WelcomeState extends Equatable {
  const WelcomeState({
    this.status = WelcomeStatus.initial,
    this.termsAccepted = false,
  });

  final WelcomeStatus status;
  final bool termsAccepted;

  WelcomeState copyWith({
    WelcomeStatus? status,
    bool? termsAccepted,
  }) {
    return WelcomeState(
      status: status ?? WelcomeStatus.initial,
      termsAccepted: termsAccepted ?? this.termsAccepted,
    );
  }

  @override
  List<Object> get props => [status, termsAccepted];
}
