part of 'promt_bloc.dart';

abstract class PromtEvent extends Equatable {
  const PromtEvent();

  @override
  List<Object> get props => [];
}

class ReloadPromtEvent extends PromtEvent {
  const ReloadPromtEvent();
}

class AddPromtEvent extends PromtEvent {
  final String data;

  const AddPromtEvent({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class SelectPromtEvent extends PromtEvent {
  final String id;

  const SelectPromtEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class RemovePromtEvent extends PromtEvent {
  final String id;

  const RemovePromtEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class RestoreSelectingPromtEvent extends PromtEvent {
  const RestoreSelectingPromtEvent();
}

class DoRandomPromtEvent extends PromtEvent {
  const DoRandomPromtEvent();
}
