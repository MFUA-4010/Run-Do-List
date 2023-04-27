import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rundolist/src/presentation/app.dart';
import 'package:rundolist/src/presentation/widgets/snacks/duration_snack_bar.dart';

part 'duration_event.dart';

class DurationBloc extends Bloc<DurationEvent, Duration> {
  DurationBloc() : super(Duration.zero) {
    on<InitDurationEvent>(_onInitDurationEvent);
    on<ChangeDurationEvent>(_onChangeDurationEvent);
  }

  FutureOr<void> _onInitDurationEvent(
    InitDurationEvent event,
    Emitter<Duration> emit,
  ) {
    //TODO: Implement from-cache restorin`

    emit(const Duration(seconds: 1));
  }

  FutureOr<void> _onChangeDurationEvent(
    ChangeDurationEvent event,
    Emitter<Duration> emit,
  ) {
    try {
      //! Global SnackBar Message

      final ctx = App.globalNavKey.currentContext;

      if (ctx != null) {
        if (event.value == null) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            DuraionSnackBar(ctx, DuraionSnackBarOption.empty),
          );
        } else if (event.value != null && (event.value ?? 0) < 0) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            DuraionSnackBar(ctx, DuraionSnackBarOption.negative),
          );
        } else {
          //TODO: Implement to-cache savin`

          emit(Duration(seconds: event.value!.toInt()));
        }
      }

      //! --
    } on FormatException {
      debugPrint('FormatException');
    }
  }
}
