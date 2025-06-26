part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailOptionPressed extends ForgotPasswordEvent {
  const ForgotPasswordEmailOptionPressed();
}

class ForgotPasswordSmsOptionPressed extends ForgotPasswordEvent {
  const ForgotPasswordSmsOptionPressed();
}

class ForgotPasswordBackPressed extends ForgotPasswordEvent {
  const ForgotPasswordBackPressed();
}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  const ForgotPasswordEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ForgotPasswordEmailSubmitted extends ForgotPasswordEvent {
  const ForgotPasswordEmailSubmitted();
}
