part of 'pseudo_bloc.dart';

abstract class PseudoEvent extends Equatable {
  const PseudoEvent();

  @override
  List<Object> get props => [];
}

class HandleCheatNumStrPseudoEvent extends PseudoEvent {
  final String? data;

  const HandleCheatNumStrPseudoEvent(this.data);

  @override
  List<Object> get props => [data ?? ''];
}

class RemovePseudoEvent extends PseudoEvent {
  const RemovePseudoEvent();
}
