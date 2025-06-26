part of 'signin_bloc.dart';

enum SigninStatus {
  initial,
  loading,
  success,
  error,
  forgotPassword,
  googleSignin,
  navigateToSignUp,
}

class SigninState extends Equatable {
  const SigninState({
    this.status = SigninStatus.initial,
    this.email = '',
    this.password = '',
    this.keepMeSignedIn = false,
    this.isPasswordVisible = false,
    this.emailError,
    this.passwordError,
  });

  final SigninStatus status;
  final String email;
  final String password;
  final bool keepMeSignedIn;
  final bool isPasswordVisible;
  final String? emailError;
  final String? passwordError;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  SigninState copyWith({
    SigninStatus? status,
    String? email,
    String? password,
    bool? keepMeSignedIn,
    bool? isPasswordVisible,
    String? emailError,
    String? passwordError,
  }) {
    return SigninState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      keepMeSignedIn: keepMeSignedIn ?? this.keepMeSignedIn,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        keepMeSignedIn,
        isPasswordVisible,
        emailError,
        passwordError,
      ];
}
