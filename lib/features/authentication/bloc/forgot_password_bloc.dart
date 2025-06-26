import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailOptionPressed>(_onEmailOptionPressed);
    on<ForgotPasswordSmsOptionPressed>(_onSmsOptionPressed);
    on<ForgotPasswordBackPressed>(_onBackPressed);
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordEmailSubmitted>(_onEmailSubmitted);
  }

  void _onEmailOptionPressed(
    ForgotPasswordEmailOptionPressed event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(status: ForgotPasswordStatus.navigateToEmailScreen));
  }

  void _onSmsOptionPressed(
    ForgotPasswordSmsOptionPressed event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(status: ForgotPasswordStatus.smsOptionSelected));
  }

  void _onBackPressed(
    ForgotPasswordBackPressed event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(status: ForgotPasswordStatus.navigateBack));
  }

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onEmailSubmitted(
    ForgotPasswordEmailSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state.email.isEmpty || !_isValidEmail(state.email)) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.emailError,
        errorMessage: 'Please enter a valid email address',
      ));
      return;
    }

    emit(state.copyWith(status: ForgotPasswordStatus.sendingEmail));

    try {
      // TODO: Implement actual email sending logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(state.copyWith(
          status: ForgotPasswordStatus.navigateToEmailSentScreen));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.emailError,
        errorMessage: 'Failed to send reset email. Please try again.',
      ));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
}
