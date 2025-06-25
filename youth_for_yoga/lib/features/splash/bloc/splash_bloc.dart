import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'splash_event.dart';
import 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashStarted>(_onSplashStarted);
    on<SplashCompleted>(_onSplashCompleted);
  }

  void _onSplashStarted(SplashStarted event, Emitter<SplashState> emit) async {
    // Wait for initial loading (show loading indicator)
    await Future.delayed(const Duration(milliseconds: 500));

    if (emit.isDone) return;
    // Start scaling animation (branding appears at 20% scale and animates to 100%)
    emit(state.copyWith(status: SplashStatus.scaling));

    if (emit.isDone) return;
    await Future.delayed(
        const Duration(milliseconds: 2000)); // 2 seconds for scale animation

    if (emit.isDone) return;
    // Complete
    add(const SplashCompleted());
  }

  void _onSplashCompleted(SplashCompleted event, Emitter<SplashState> emit) {
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
