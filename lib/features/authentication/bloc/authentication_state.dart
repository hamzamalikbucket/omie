import 'package:equatable/equatable.dart';

enum AuthenticationStatus {
  initial,
  loading,
  authenticated,
  error,
  navigatingToEmailSignIn,
}

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.initial,
    this.errorMessage,
  });

  final AuthenticationStatus status;
  final String? errorMessage;

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    String? errorMessage,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
