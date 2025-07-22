import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(const SigninState()) {
    on<SigninEmailChanged>(_onEmailChanged);
    on<SigninPasswordChanged>(_onPasswordChanged);
    on<SigninKeepMeSignedInToggled>(_onKeepMeSignedInToggled);
    on<SigninPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<SigninSubmitted>(_onSubmitted);
    on<SigninForgotPasswordPressed>(_onForgotPasswordPressed);
    on<SigninGooglePressed>(_onGooglePressed);
    on<SigninSignUpPressed>(_onSignUpPressed);
    on<SigninErrorCleared>(_onErrorCleared);
  }

  void _onEmailChanged(
    SigninEmailChanged event,
    Emitter<SigninState> emit,
  ) {
    // Real-time email validation
    String? emailError;
    if (event.email.isNotEmpty && !_isValidEmail(event.email)) {
      emailError = 'Please enter a valid email address';
    }

    emit(state.copyWith(
      email: event.email,
      emailError: emailError,
      status: SigninStatus.initial,
    ));
  }

  void _onPasswordChanged(
    SigninPasswordChanged event,
    Emitter<SigninState> emit,
  ) {
    // Real-time password validation
    String? passwordError;
    if (event.password.isNotEmpty) {
      final validation = _validatePassword(event.password);
      if (validation != null) {
        passwordError = validation;
      }
    }

    emit(state.copyWith(
      password: event.password,
      passwordError: passwordError,
      status: SigninStatus.initial,
    ));
  }

  void _onKeepMeSignedInToggled(
    SigninKeepMeSignedInToggled event,
    Emitter<SigninState> emit,
  ) {
    emit(state.copyWith(keepMeSignedIn: !state.keepMeSignedIn));
  }

  void _onPasswordVisibilityToggled(
    SigninPasswordVisibilityToggled event,
    Emitter<SigninState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onSubmitted(
    SigninSubmitted event,
    Emitter<SigninState> emit,
  ) async {
    // Comprehensive form validation on submit
    String? emailError;
    String? passwordError;

    // Email validation
    if (state.email.isEmpty) {
      emailError = 'Email address is required';
    } else if (!_isValidEmail(state.email)) {
      emailError = 'Please enter a valid email address';
    }

    // Password validation
    if (state.password.isEmpty) {
      passwordError = 'Password is required';
    } else {
      final validation = _validatePassword(state.password);
      if (validation != null) {
        passwordError = validation;
      }
    }

    if (emailError != null || passwordError != null) {
      emit(state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        status: SigninStatus.error,
      ));
      return;
    }

    emit(state.copyWith(status: SigninStatus.loading));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: SigninStatus.success));
    // For demo purposes, show error if password is not 'correct_password'
   /* if (state.password != 'Password123!') {
      emit(state.copyWith(
        status: SigninStatus.error,
        passwordError: 'Incorrect password! Please enter the correct password.',
      ));
    } else {

    }*/
  }

  void _onForgotPasswordPressed(
    SigninForgotPasswordPressed event,
    Emitter<SigninState> emit,
  ) {
    emit(state.copyWith(status: SigninStatus.forgotPassword));
  }

  void _onGooglePressed(
    SigninGooglePressed event,
    Emitter<SigninState> emit,
  ) {
    emit(state.copyWith(status: SigninStatus.googleSignin));
  }

  void _onSignUpPressed(
    SigninSignUpPressed event,
    Emitter<SigninState> emit,
  ) {
    emit(state.copyWith(status: SigninStatus.navigateToSignUp));
  }

  void _onErrorCleared(
    SigninErrorCleared event,
    Emitter<SigninState> emit,
  ) {
    emit(state.copyWith(
      status: SigninStatus.initial,
      emailError: null,
      passwordError: null,
    ));
  }

  // Enhanced email validation
  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
    ).hasMatch(email);
  }

  // Comprehensive password validation
  String? _validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }
}
