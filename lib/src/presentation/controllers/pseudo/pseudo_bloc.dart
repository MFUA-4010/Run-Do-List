import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'pseudo_event.dart';

/// Admin Features [Bloc]
class PseudoBloc extends Bloc<PseudoEvent, int?> {
  PseudoBloc() : super(null) {
    on<HandleCheatNumStrPseudoEvent>(_onHadleKeySetPseudoEvent);
    on<RemovePseudoEvent>(_onRemovePseudoEvent);
  }

  //! EVENT HANDLERS

  /// [PseudoBloc] method that handles [HandleCheatNumStrPseudoEvent]

  FutureOr<void> _onHadleKeySetPseudoEvent(
    HandleCheatNumStrPseudoEvent event,
    Emitter<int?> emit,
  ) {
    try {
      final String newLine = '${state ?? ''}${event.data ?? ''}';
      final int? data = int.tryParse(newLine);

      emit(data);
    } catch (e) {
      emit(null);
    }
  }

  FutureOr<void> _onRemovePseudoEvent(
    RemovePseudoEvent event,
    Emitter<int?> emit,
  ) {
    emit(null);
  }
}
