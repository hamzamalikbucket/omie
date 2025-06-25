import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SplashStarted extends SplashEvent {
  const SplashStarted();
}

class SplashCompleted extends SplashEvent {
  const SplashCompleted();
}
