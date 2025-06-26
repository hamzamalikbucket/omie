import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<SignInWithGooglePressed>(_onSignInWithGooglePressed);
    on<SignInWithApplePressed>(_onSignInWithApplePressed);
    on<SignInWithEmailPressed>(_onSignInWithEmailPressed);
    on<SignUpPressed>(_onSignUpPressed);
    on<NavigateToEmailSignIn>(_onNavigateToEmailSignIn);
    on<EmailSignInSubmitted>(_onEmailSignInSubmitted);
  }

  Future<void> _onSignInWithGooglePressed(
    SignInWithGooglePressed event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    // TODO: Implement Google sign in logic
    await Future.delayed(const Duration(seconds: 1));

    // For now, just show a success state
    emit(state.copyWith(status: AuthenticationStatus.authenticated));
  }

  Future<void> _onSignInWithApplePressed(
    SignInWithApplePressed event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    // TODO: Implement Apple sign in logic
    await Future.delayed(const Duration(seconds: 1));

    // For now, just show a success state
    emit(state.copyWith(status: AuthenticationStatus.authenticated));
  }

  Future<void> _onSignInWithEmailPressed(
    SignInWithEmailPressed event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    // Navigate to email sign in screen
    await Future.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(status: AuthenticationStatus.navigatingToEmailSignIn));
  }

  Future<void> _onSignUpPressed(
    SignUpPressed event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    // Navigate to sign up screen
    await Future.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(status: AuthenticationStatus.navigatingToSignUp));
  }

  Future<void> _onNavigateToEmailSignIn(
    NavigateToEmailSignIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.navigatingToEmailSignIn));
  }

  Future<void> _onEmailSignInSubmitted(
    EmailSignInSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    // TODO: Implement email sign in logic
    await Future.delayed(const Duration(seconds: 1));

    // For demonstration, show error if password is incorrect
    if (event.password != 'correct_password') {
      emit(state.copyWith(
        status: AuthenticationStatus.error,
        errorMessage: 'Incorrect password! Please enter the correct password.',
      ));
    } else {
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
    }
  }
}
