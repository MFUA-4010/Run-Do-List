part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class InitCounterEvent extends CounterEvent {
  const InitCounterEvent();
}

class ChangeCounterEvent extends CounterEvent {
  final num? value;

  const ChangeCounterEvent(this.value);
}
