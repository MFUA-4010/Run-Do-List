part of 'promt_bloc.dart';

enum RandomProgress {
  onClose,
  onProgress,
  onFinished,
}

abstract class PromtState extends Equatable {
  const PromtState();

  @override
  List<Object> get props => [];
}

class InitialPromtState extends PromtState {
  const InitialPromtState();
}

class LoadedPromtState extends PromtState {
  final StreamController<bool> chipController;
  final List<Promt> promts;
  final bool changedPromtsFlag;
  final RandomProgress randomProgress;
  final Promt? result;

  const LoadedPromtState({
    required this.chipController,
    required this.promts,
    this.changedPromtsFlag = false,
    this.randomProgress = RandomProgress.onClose,
    this.result,
  });

  @override
  List<Object> get props => [promts, changedPromtsFlag, randomProgress];
}
