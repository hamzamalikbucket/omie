part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class WelcomeTermsToggled extends WelcomeEvent {
  const WelcomeTermsToggled();
}

class WelcomeGetStarted extends WelcomeEvent {
  const WelcomeGetStarted();
}

class WelcomeSignInPressed extends WelcomeEvent {
  const WelcomeSignInPressed();
}
