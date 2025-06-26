import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGooglePressed extends AuthenticationEvent {
  const SignInWithGooglePressed();
}

class SignInWithApplePressed extends AuthenticationEvent {
  const SignInWithApplePressed();
}

class SignInWithEmailPressed extends AuthenticationEvent {
  const SignInWithEmailPressed();
}

class SignUpPressed extends AuthenticationEvent {
  const SignUpPressed();
}

class NavigateToEmailSignIn extends AuthenticationEvent {
  const NavigateToEmailSignIn();
}

class EmailSignInSubmitted extends AuthenticationEvent {
  const EmailSignInSubmitted({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
