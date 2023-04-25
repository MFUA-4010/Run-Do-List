import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/presentation/app.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/widgets/dialogs/change_promt_dialog.dart';
import 'package:rundolist/src/presentation/widgets/snacks/empty_snack_bar.dart';
import 'package:uuid/uuid.dart';

part 'promt_event.dart';
part 'promt_state.dart';

class PromtBloc extends Bloc<PromtEvent, PromtState> {
  PromtBloc() : super(const InitialPromtState()) {
    on<ReloadPromtEvent>(_onReloadPromtEvent);
    on<AddPromtEvent>(_onAddPromtEvent);
    on<SelectPromtEvent>(_onSelectPromtEvent);
    on<RemovePromtEvent>(_onRemovePromtEvent);
    on<RestoreSelectingPromtEvent>(_onRestoreSelectingPromtEvent);
    on<DoRandomPromtEvent>(_onDoRandomPromtEvent);

    add(const ReloadPromtEvent());
  }

  final _chipController = StreamController<bool>();

  FutureOr<void> _onReloadPromtEvent(
    ReloadPromtEvent event,
    Emitter<PromtState> emit,
  ) {
    emit(
      //TODO: Implement service loading
      LoadedPromtState(
        promts: const [],
        chipController: _chipController,
      ),
    );
  }

  FutureOr<void> _onAddPromtEvent(
    AddPromtEvent event,
    Emitter<PromtState> emit,
  ) {
    if (state is LoadedPromtState) {
      final controller = StreamController<bool>();

      controller.add(false);

      final promts = <Promt>[
        ...(state as LoadedPromtState).promts,
        Promt(
          id: const Uuid().v1(),
          data: event.data,
          controller: controller,
        ),
      ];

      controller.add(true);

      emit(
        LoadedPromtState(
          promts: promts,
          chipController: _chipController,
        ),
      );
    }
  }

  // Store currently editing [Promt] id on [ProntState]
  // Needs to be stored for remove feature reaction
  String? editingPromtId;

  FutureOr<void> _onSelectPromtEvent(
    SelectPromtEvent event,
    Emitter<PromtState> emit,
  ) async {
    /** DEPRECATED
     * 
     * Promt deselect`
    if (state is LoadedPromtState) {
      (state as LoadedPromtState)
          .promts
          .firstWhere(
            (element) => element.id == event.id,
          )
          .controller
          .add(false);
    }
    */

    editingPromtId = event.id;

    // Flag recovery
    emit(
      LoadedPromtState(
        promts: (state as LoadedPromtState).promts,
        chipController: _chipController,
        randomProgress: (state as LoadedPromtState).randomProgress,
        result: (state as LoadedPromtState).result,
      ),
    );

    // New [Promt] Storage
    final promts = <Promt>[];
    promts.addAll((state as LoadedPromtState).promts);

    // Previous [Promt]
    final Promt promt = (state as LoadedPromtState).promts.firstWhere(
          (element) => element.id == event.id,
        );

    //! Global Dialog Message

    final ctx = App.globalNavKey.currentContext;

    if (ctx != null) {
      // Await [String] value as future [Promt] data for update from [ChangePromtDialog]
      final updatedData = await showDialog<String?>(
        context: ctx,
        builder: (_) => ChangePromtDialog(
          initialValue: promt.data,
        ),
      );

      if (updatedData != null) {
        // New [Promt] for change
        final updatedPromt = Promt(
          id: promt.id,
          data: updatedData,
          controller: promt.controller,
        );

        // Write changes
        promts.removeWhere((element) => element.id == event.id);
        promts.add(updatedPromt);

        emit(
          LoadedPromtState(
            promts: promts,
            changedPromtsFlag: true,
            chipController: _chipController,
            randomProgress: (state as LoadedPromtState).randomProgress,
            result: (state as LoadedPromtState).result,
          ),
        );
      }
    }

    //! --

    editingPromtId = null;
  }

  FutureOr<void> _onRemovePromtEvent(
    RemovePromtEvent event,
    Emitter<PromtState> emit,
  ) {
    // New [Promt] Storage
    final promts = <Promt>[];
    promts.addAll((state as LoadedPromtState).promts);

    // Write changes
    promts.removeWhere((element) => element.id == event.id);

    emit(
      LoadedPromtState(
        promts: promts,
        changedPromtsFlag: true,
        chipController: _chipController,
        randomProgress: (state as LoadedPromtState).randomProgress,
        result: (state as LoadedPromtState).result,
      ),
    );
  }

  Future<FutureOr<void>> _onRestoreSelectingPromtEvent(
    RestoreSelectingPromtEvent event,
    Emitter<PromtState> emit,
  ) async {
    //! Random Removing Animation Fix

    final animationDuration = services<DurationBloc>().state;
    await Future.delayed(animationDuration);

    //! --

    if (state is LoadedPromtState) {
      for (final e in (state as LoadedPromtState).promts) {
        e.controller.add(true);
      }

      _chipController.add(true);

      emit(
        LoadedPromtState(
          promts: (state as LoadedPromtState).promts,
          chipController: _chipController,
        ),
      );
    }
  }

  FutureOr<void> _onDoRandomPromtEvent(
    DoRandomPromtEvent event,
    Emitter<PromtState> emit,
  ) async {
    if (state is LoadedPromtState) {
      final progress = (state as LoadedPromtState).randomProgress;

      switch (progress) {
        case RandomProgress.onClose:
          removeCheck = false;

          if ((state as LoadedPromtState).promts.isEmpty) {
            //! Global SnackBar Message

            final ctx = App.globalNavKey.currentContext;

            if (ctx != null) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                EmptySnackBar(ctx),
              );
            }

            //! --
          } else {
            emit(
              LoadedPromtState(
                promts: (state as LoadedPromtState).promts,
                chipController: _chipController,
                randomProgress: RandomProgress.onProgress,
              ),
            );

            _chipController.add(false);
            await startRandomRemoving(
              state as LoadedPromtState,
              (result) async {
                emit(
                  LoadedPromtState(
                    promts: (state as LoadedPromtState).promts,
                    chipController: _chipController,
                    randomProgress: RandomProgress.onFinished,
                    result: (state as LoadedPromtState).promts.elementAt(result),
                  ),
                );

                await Future.delayed(const Duration(seconds: 1));
                add(const RestoreSelectingPromtEvent());
              },
            );
          }

          break;

        case RandomProgress.onProgress:
          removeCheck = true;
          emit(
            LoadedPromtState(
              promts: (state as LoadedPromtState).promts,
              chipController: _chipController,
            ),
          );

          add(const RestoreSelectingPromtEvent());
          break;

        case RandomProgress.onFinished:
          break;
      }
    }
  }

  bool removeCheck = false;

  FutureOr<void> startRandomRemoving(
    LoadedPromtState state,
    void Function(int) onFinished,
  ) async {
    final int finalResult = Random().nextInt(state.promts.length);
    final rnd = <int>[];

    for (int i = 0; i < state.promts.length - 1; i++) {
      if (removeCheck) break;

      //! First Half of entered Duraion

      final animationDuration = services<DurationBloc>().state;
      await Future.delayed(Duration(milliseconds: animationDuration.inMilliseconds ~/ 2));

      //! --

      int random;

      do {
        random = Random().nextInt(state.promts.length);
      } while (rnd.contains(random) || random == finalResult);

      rnd.add(random);

      final controller = state.promts.elementAt(random).controller;
      controller.add(false);

      //! Second Half of entered Duraion

      await Future.delayed(Duration(milliseconds: animationDuration.inMilliseconds ~/ 2));

      //! --
    }

    if (removeCheck) return;

    await Future.delayed(
      const Duration(seconds: 1),
    );

    onFinished(finalResult);
  }
}
