import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIncrement extends CounterEvent {
  const CounterIncrement();
}

class CounterDecrement extends CounterEvent {
  const CounterDecrement();
}

class CounterReset extends CounterEvent {
  const CounterReset();
}
