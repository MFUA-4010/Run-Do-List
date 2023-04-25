part of 'duration_bloc.dart';

abstract class DurationEvent extends Equatable {
  const DurationEvent();

  @override
  List<Object> get props => [];
}

class InitDurationEvent extends DurationEvent {
  const InitDurationEvent();
}

class ChangeDurationEvent extends DurationEvent {
  final num? value;

  const ChangeDurationEvent(this.value);
}
