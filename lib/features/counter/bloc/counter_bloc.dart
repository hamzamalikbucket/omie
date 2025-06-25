import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'counter_event.dart';
import 'counter_state.dart';

@injectable
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncrement>(_onIncrement);
    on<CounterDecrement>(_onDecrement);
    on<CounterReset>(_onReset);
  }

  void _onIncrement(CounterIncrement event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      status: CounterStatus.loading,
    ));

    // Simulate async operation
    Future.delayed(const Duration(milliseconds: 300), () {
      emit(state.copyWith(
        status: CounterStatus.success,
        value: state.value + 1,
      ));
    });
  }

  void _onDecrement(CounterDecrement event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      status: CounterStatus.loading,
    ));

    // Simulate async operation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (state.value > 0) {
        emit(state.copyWith(
          status: CounterStatus.success,
          value: state.value - 1,
        ));
      } else {
        emit(state.copyWith(
          status: CounterStatus.failure,
          errorMessage: 'Counter cannot be negative',
        ));
      }
    });
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      status: CounterStatus.success,
      value: 0,
      errorMessage: null,
    ));
  }
}
