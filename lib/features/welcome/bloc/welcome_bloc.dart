import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<WelcomeTermsToggled>(_onTermsToggled);
    on<WelcomeGetStarted>(_onGetStarted);
    on<WelcomeSignInPressed>(_onSignInPressed);
  }

  void _onTermsToggled(
    WelcomeTermsToggled event,
    Emitter<WelcomeState> emit,
  ) {
    emit(state.copyWith(termsAccepted: !state.termsAccepted));
  }

  void _onGetStarted(
    WelcomeGetStarted event,
    Emitter<WelcomeState> emit,
  ) {
    if (state.termsAccepted) {
      emit(state.copyWith(status: WelcomeStatus.navigatingToHome));
    }
  }

  void _onSignInPressed(
    WelcomeSignInPressed event,
    Emitter<WelcomeState> emit,
  ) {
    emit(state.copyWith(status: WelcomeStatus.navigatingToSignIn));
  }
}
