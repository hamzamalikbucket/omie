part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus {
  initial,
  emailOptionSelected,
  smsOptionSelected,
  navigateBack,
  navigateToEmailScreen,
  sendingEmail,
  emailSent,
  emailError,
  navigateToEmailSentScreen,
}

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.email = '',
    this.errorMessage = '',
  });

  final ForgotPasswordStatus status;
  final String email;
  final String errorMessage;

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? email,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, email, errorMessage];
}
