import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/usecases/counter/restore_counter_usecase.dart';
import 'package:rundolist/src/domain/usecases/counter/update_counter_usecase.dart';
import 'package:rundolist/src/domain/usecases/promts/clear_cached_promts_usecase.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';
import 'package:rundolist/src/presentation/widgets/snack_bars/empty_count_error_snack_bar.dart';
import 'package:rundolist/src/presentation/widgets/snack_bars/negative_count_error_snack_bar.dart';
import 'package:rundolist/src/presentation/widgets/snack_bars/up_count_error_snack_bar.dart';
import 'package:rundolist/utils/global_context_mixin.dart';

part 'counter_event.dart';

/// Control random count [Bloc]
class CounterBloc extends Bloc<CounterEvent, int> with GlobalContextMixin {
  /// Default random count for [CounterBloc]
  static const int defaultCount = 1;

  CounterBloc() : super(defaultCount) {
    on<InitCounterEvent>(_onInitCounterEvent);
    on<ChangeCounterEvent>(_onChangeCounterEvent);

    add(const InitCounterEvent());
  }

  /// Emit count with negative time check
  FutureOr<void> emitCounter(
    int counter,
    Emitter<int> emit,
  ) {
    if (counter.isNegative) {
      emit(defaultCount);

      return null;
    }

    emit(counter);
  }

  //! EVENT HANDLERS

  /// [CounterBloc] method that handles [InitCounterEvent]
  FutureOr<void> _onInitCounterEvent(
    InitCounterEvent event,
    Emitter<int> emit,
  ) async {
    final countOrError = await RestoreCounterUseCase().call(
      const NoParam(),
    );

    countOrError.fold(
      (error) {
        emitCounter(
          defaultCount,
          emit,
        );
      },
      (value) {
        emit(value);
      },
    );
  }

  /// [CounterBloc] method that handles [ChangeCounterEvent]
  FutureOr<void> _onChangeCounterEvent(
    ChangeCounterEvent event,
    Emitter<int> emit,
  ) async {
    if (event.value == null) {
      showGlobalSnackBar(EmptyCountErrorSnackBar(context!));

      return;
    }

    final int count = event.value!.toInt();

    if (count < 1) {
      showGlobalSnackBar(NegativeCountErrorSnackBar(context!));

      return;
    }

    final promtState = services<PromtBloc>().state;
    if (promtState is LoadedPromtState) {
      if (promtState.promts.length < count) {
        showGlobalSnackBar(UpCountErrorSnackBar(context!));

        return;
      }
    }

    emitCounter(
      count,
      emit,
    );

    await UpdateCounterUseCase().call(count);
  }
}
