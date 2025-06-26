part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninEmailChanged extends SigninEvent {
  const SigninEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SigninPasswordChanged extends SigninEvent {
  const SigninPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SigninKeepMeSignedInToggled extends SigninEvent {
  const SigninKeepMeSignedInToggled();
}

class SigninPasswordVisibilityToggled extends SigninEvent {
  const SigninPasswordVisibilityToggled();
}

class SigninSubmitted extends SigninEvent {
  const SigninSubmitted();
}

class SigninForgotPasswordPressed extends SigninEvent {
  const SigninForgotPasswordPressed();
}

class SigninGooglePressed extends SigninEvent {
  const SigninGooglePressed();
}

class SigninSignUpPressed extends SigninEvent {
  const SigninSignUpPressed();
}

class SigninErrorCleared extends SigninEvent {
  const SigninErrorCleared();
}
