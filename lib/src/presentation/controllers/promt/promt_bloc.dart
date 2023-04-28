import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/entities/enums/fade.dart';
import 'package:rundolist/src/domain/entities/enums/progress.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/domain/usecases/promts/restore_cached_promts_usecase.dart';
import 'package:rundolist/src/domain/usecases/promts/update_cacahed_promts_usecase.dart';
import 'package:rundolist/src/presentation/controllers/counter/counter_bloc.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/widgets/dialogs/change_promt_dialog.dart';
import 'package:rundolist/src/presentation/widgets/snack_bars/empty_promt_error_snack_bar.dart';
import 'package:rundolist/utils/global_context_mixin.dart';
import 'package:uuid/uuid.dart';

part 'promt_event.dart';
part 'promt_state.dart';

/// Home page controller [Bloc]
class PromtBloc extends Bloc<PromtEvent, PromtState> with GlobalContextUtil {
  /// [PromtBloc] constructor that handles all [Bloc] events
  PromtBloc() : super(const InitialPromtState()) {
    on<ReloadPromtEvent>(_onReloadPromtEvent);
    on<AddPromtEvent>(_onAddPromtEvent);
    on<SelectPromtEvent>(_onSelectPromtEvent);
    on<RemovePromtEvent>(_onRemovePromtEvent);
    on<RestoreFadePromtEvent>(_onRestoreFadePromtEvent);
    on<DoRandomPromtEvent>(_onDoRandomPromtEvent);

    /// Call initial event on load application
    add(const ReloadPromtEvent());
  }

  /// Boolean checker for break [_doRandomHiding] removing
  bool _removeCheck = false;

  /// Method for randomize hide promts from [LoadedPromtState]
  FutureOr<void> _doRandomHiding(
    LoadedPromtState state,
    void Function(List<int>) onFinished,
  ) async {
    final finalResultsCount = services<CounterBloc>().state;

    // /// Prepare final random element index
    // final int finalResult = Random().nextInt(state.promts.length);

    /// Next element index that will be fade
    int nextRandom;

    final List<int> finalResults = <int>[];

    for (int i = 0; i < finalResultsCount; i++) {
      do {
        nextRandom = Random().nextInt(state.promts.length);
      } while (finalResults.contains(nextRandom));
      finalResults.add(nextRandom);
    }

    /// Storing elements that have been fade
    final List<int> hidedPromts = <int>[];

    for (int i = 0; i < state.promts.length - finalResultsCount; i++) {
      /// Stop [_randomFadePromts] method if [_removeCheck] before animation
      if (_removeCheck) break;

      //? First Half of entered Duraion
      final animationDuration = services<DurationBloc>().state;
      await Future.delayed(Duration(milliseconds: animationDuration.inMilliseconds ~/ 2));
      /////

      /// Re-roll next element index if one `s already in fade
      do {
        nextRandom = Random().nextInt(state.promts.length);
      } while (hidedPromts.contains(nextRandom) || finalResults.contains(nextRandom));

      /// Store generated [nextRandom] for calc next generations
      hidedPromts.add(nextRandom);

      /// Retriev Fade [StreamController] of current fading element
      final controller = state.promts.elementAt(nextRandom).fadeController;

      /// Fade current element
      controller.add(Fade.half);

      /// Stop [_randomFadePromts] method if [_removeCheck] after fade
      if (_removeCheck) break;

      //? Second Half of entered Duraion
      await Future.delayed(Duration(milliseconds: animationDuration.inMilliseconds ~/ 2));
      /////
    }

    /// Stop [_randomFadePromts] method if [_removeCheck] after all elem's have been faded
    if (_removeCheck) return;

    /// Await delay before show [ResultPage]
    await Future.delayed(
      //? Implement options
      const Duration(seconds: 1),
    );

    /// Return pseudo result
    onFinished(finalResults);
  }

//! HANDLERS

  /// [PromtBloc] method that handles [ReloadPromtEvent]
  Future<FutureOr<void>> _onReloadPromtEvent(
    ReloadPromtEvent event,
    Emitter<PromtState> emit,
  ) async {
    /// New fade [StreamController] for 'add promt' button
    final StreamController<Fade> fadeController = StreamController<Fade>();

    final dataOrError = await RestoreCachedPromtsUseCase().call(const NoParam());

    dataOrError.fold(
      (error) {
        emit(
          LoadedPromtState(
            promts: const [],
            buttonFadeController: fadeController,
          ),
        );
      },
      (data) {
        emit(
          LoadedPromtState(
            promts: data,
            buttonFadeController: fadeController,
          ),
        );
      },
    );
  }

  /// [PromtBloc] method that handles [AddPromtEvent]
  FutureOr<void> _onAddPromtEvent(
    AddPromtEvent event,
    Emitter<PromtState> emit,
  ) {
    if (state is! LoadedPromtState) {
      throw UnimplementedError();
    }

    final LoadedPromtState qState = state as LoadedPromtState;

    /// New fade [StreamController] for 'promt' chip
    final StreamController<Fade> fadeController = StreamController<Fade>();

    /// New 'promt' chip animation start point
    fadeController.add(Fade.hide);

    /// Storage for promts after add new one
    final promts = <Promt>[];

    /// Add all prev. promts
    promts.addAll(qState.promts);

    promts.add(
      Promt(
        id: const Uuid().v1(),
        data: event.data,
        fadeController: fadeController,
      ),
    );

    /// Start new 'promt' animation
    fadeController.add(Fade.show);

    emit(
      LoadedPromtState(
        progress: qState.progress,
        promts: promts,
        buttonFadeController: qState.buttonFadeController,
      ),
    );

    /// Update promts in application cache
    UpdateCachedPromtsUseCase().call(promts);
  }

  /// Store currently editing [Promt] id on [ProntState]
  /// Needs to be stored for remove feature reaction
  String? _lastEditID;

  String? get lastEditID => _lastEditID;

  /// Override [_lastEditID] set with out-of-id checking
  set lastEditID(String? id) {
    if (state is! LoadedPromtState) {
      _lastEditID = null;
    }

    final LoadedPromtState qState = state as LoadedPromtState;

    if (qState.promts.where((element) => element.id == id).isEmpty) {
      _lastEditID = null;
    }

    _lastEditID = id;
  }

  /// [PromtBloc] method that handles [SelectPromtEvent]
  FutureOr<void> _onSelectPromtEvent(
    SelectPromtEvent event,
    Emitter<PromtState> emit,
  ) async {
    if (state is! LoadedPromtState) {
      _lastEditID = null;
    }

    final LoadedPromtState qState = state as LoadedPromtState;

    // Update flag cause of start editing
    lastEditID = event.id;

    /// Recover flag for next [SelectPromtState]
    emit(
      LoadedPromtState(
        progress: qState.progress,
        resultPromts: qState.resultPromts,
        promts: qState.promts,
        buttonFadeController: qState.buttonFadeController,
      ),
    );

    /// New [Promt] Storage
    final promts = <Promt>[];
    promts.addAll(qState.promts);

    /// Previous [Promt]
    final Promt promt = qState.promts.firstWhere(
      (element) => element.id == event.id,
    );

    await showGlobalDialog<String>(
      ChangePromtDialog(
        initialValue: promt.data,
      ),
      (String data) {
        /// Prepare [Promt] for update
        final Promt update = Promt(
          id: promt.id,
          data: data,
          fadeController: promt.fadeController,
        );

        /// Remove prev [Promt]
        promts.removeWhere((element) => element.id == event.id);

        /// Add updated [Promt]
        promts.add(update);

        emit(
          LoadedPromtState(
            progress: qState.progress,
            reloadFlag: true,
            resultPromts: qState.resultPromts,
            promts: promts,
            buttonFadeController: qState.buttonFadeController,
          ),
        );

        /// Update promts in application cache
        UpdateCachedPromtsUseCase().call(promts);
      },
    );

    // Update flag cause of end editing
    lastEditID = null;
  }

  /// [PromtBloc] method that handles [RemovePromtEvent]
  FutureOr<void> _onRemovePromtEvent(
    RemovePromtEvent event,
    Emitter<PromtState> emit,
  ) {
    if (state is! LoadedPromtState) {
      _lastEditID = null;
    }

    final LoadedPromtState qState = state as LoadedPromtState;

    final counterBloc = services<CounterBloc>();

    ///
    if (counterBloc.state < qState.promts.length - 1) {
      counterBloc.add(ChangeCounterEvent(qState.promts.length - 1));
    }

    /// New [Promt] Storage
    final promts = <Promt>[];
    promts.addAll(qState.promts);

    /// Write changes
    promts.removeWhere((element) => element.id == event.id);

    emit(
      LoadedPromtState(
        buttonFadeController: qState.buttonFadeController,
        reloadFlag: true,
        progress: qState.progress,
        promts: promts,
        resultPromts: qState.resultPromts,
      ),
    );

    /// Update promts in application cache
    UpdateCachedPromtsUseCase().call(promts);
  }

  /// [PromtBloc] method that handles [RestoreFadePromtEvent]
  Future<FutureOr<void>> _onRestoreFadePromtEvent(
    RestoreFadePromtEvent event,
    Emitter<PromtState> emit,
  ) async {
    if (state is! LoadedPromtState) {
      _lastEditID = null;
    }

    final LoadedPromtState qState = state as LoadedPromtState;

    /// Restore hided elements
    qState.buttonFadeController.add(Fade.show);
    for (final Promt el in qState.promts) {
      el.fadeController.add(Fade.show);
    }

    //! Random removing duration animation fix repeat
    final animationDuration = services<DurationBloc>().state;
    await Future.delayed(animationDuration);

    qState.buttonFadeController.add(Fade.show);
    for (final Promt el in qState.promts) {
      el.fadeController.add(Fade.show);
    }
    //!

    emit(
      LoadedPromtState(
        resultPromts: qState.resultPromts,
        promts: qState.promts,
        buttonFadeController: qState.buttonFadeController,
      ),
    );
  }

  /// [PromtBloc] method that handles [DoRandomPromtEvent]
  FutureOr<void> _onDoRandomPromtEvent(
    DoRandomPromtEvent event,
    Emitter<PromtState> emit,
  ) async {
    if (state is! LoadedPromtState) {
      _lastEditID = null;
    }

    final LoadedPromtState qState = state as LoadedPromtState;

    switch (qState.progress) {
      case Progress.inactive:
        _removeCheck = false;

        if (qState.promts.isEmpty) {
          showGlobalSnackBar(
            EmptyPromtErrorSnackBar(context!),
          );
        } else {
          /// Hide add button on start randomizing
          qState.buttonFadeController.add(Fade.hide);

          emit(
            LoadedPromtState(
              progress: Progress.active,
              promts: qState.promts,
              buttonFadeController: qState.buttonFadeController,
            ),
          );

          /// Start randomizing animations
          await _doRandomHiding(
            qState,
            (List<int> results) async {
              emit(
                LoadedPromtState(
                  progress: Progress.done,
                  resultPromts: results.map((i) {
                    return qState.promts.elementAt(i);
                  }).toList(),
                  promts: qState.promts,
                  buttonFadeController: qState.buttonFadeController,
                ),
              );

              /// Restore all [Promt] chips on background
              await Future.delayed(const Duration(seconds: 1), () {
                add(const RestoreFadePromtEvent());
              });
            },
          );
        }
        break;

      case Progress.active:
        _removeCheck = true;

        emit(
          LoadedPromtState(
            promts: qState.promts,
            buttonFadeController: qState.buttonFadeController,
          ),
        );

        add(const RestoreFadePromtEvent());
        break;

      case Progress.done:
        break;
    }
  }
}
