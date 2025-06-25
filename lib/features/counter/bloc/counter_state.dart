import 'package:equatable/equatable.dart';

enum CounterStatus {
  initial,
  loading,
  success,
  failure,
}

class CounterState extends Equatable {
  const CounterState({
    this.status = CounterStatus.initial,
    this.value = 0,
    this.errorMessage,
  });

  final CounterStatus status;
  final int value;
  final String? errorMessage;

  CounterState copyWith({
    CounterStatus? status,
    int? value,
    String? errorMessage,
  }) {
    return CounterState(
      status: status ?? this.status,
      value: value ?? this.value,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, value, errorMessage];
}
