part of 'promt_bloc.dart';

/// [PromtBloc] States
abstract class PromtState extends Equatable {
  const PromtState();

  @override
  List<Object> get props => [];
}

/// [PromtBloc] initialization [PromtState]
class InitialPromtState extends PromtState {
  const InitialPromtState();
}

/// [PromtState] that storing data for rendering home page
class LoadedPromtState extends PromtState {
  final Progress progress;

  final bool reloadFlag;

  final Promt? randomPromt;
  final List<Promt> promts;

  final StreamController<Fade> buttonFadeController;

  const LoadedPromtState({
    this.progress = Progress.inactive,
    this.reloadFlag = false,
    this.randomPromt,
    required this.promts,
    required this.buttonFadeController,
  });

  @override
  List<Object> get props => [reloadFlag, progress, promts];
}
