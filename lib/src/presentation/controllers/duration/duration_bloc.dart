import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/usecases/duration/restore_duration_usecase.dart';
import 'package:rundolist/src/domain/usecases/duration/update_duration_usecase.dart';
import 'package:rundolist/src/presentation/widgets/snack_bars/empty_duration_error_snack_bar.dart';
import 'package:rundolist/src/presentation/widgets/snack_bars/nagative_duration_error_snack_bar.dart';
import 'package:rundolist/utils/global_context_mixin.dart';

part 'duration_event.dart';

/// Control removal duration [Bloc]
class DurationBloc extends Bloc<DurationEvent, Duration> with GlobalContextUtil {
  /// Default [Duration] for [DurationBloc]
  static const Duration defaultDuration = Duration(seconds: 1);

  /// [DurationBloc] constructor that handles all [Bloc] events
  DurationBloc() : super(defaultDuration) {
    on<InitDurationEvent>(_onInitDurationEvent);
    on<ChangeDurationEvent>(_onChangeDurationEvent);

    /// Call initial event on load application
    add(const InitDurationEvent());
  }

  /// Emit new [Duration] with negative time check
  FutureOr<void> emitDuration(
    Duration duration,
    Emitter<Duration> emit,
  ) {
    if (duration.isNegative) {
      emit(defaultDuration);
      return null;
    }

    emit(duration);
  }

  //! EVENT HANDLERS

  /// [DurationBloc] method that handles [InitDurationEvent]
  Future<FutureOr<void>> _onInitDurationEvent(
    InitDurationEvent event,
    Emitter<Duration> emit,
  ) async {
    final durationOrError = await RestoreDurationUseCase().call(
      const NoParam(),
    );

    durationOrError.fold(
      (error) {
        emitDuration(
          defaultDuration,
          emit,
        );
      },
      (value) {
        emit(value);
      },
    );
  }

  /// [DurationBloc] method that handles [ChangeDurationEvent]
  Future<FutureOr<void>> _onChangeDurationEvent(
    ChangeDurationEvent event,
    Emitter<Duration> emit,
  ) async {
    if (event.value == null) {
      showGlobalSnackBar(EmptyDurationErrorSnackBar(context!));
    } else if (event.value != null && (event.value ?? 0) < 0) {
      showGlobalSnackBar(NegativeDurationErrorSnackBar(context!));
    } else {
      final Duration duration = Duration(
        seconds: event.value?.toInt() ?? defaultDuration.inSeconds,
      );

      emitDuration(
        duration,
        emit,
      );

      await UpdateDurationUseCase().call(duration);
    }
  }
}
