import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/usecases/theme/restore_cached_theme_usecase.dart';
import 'package:rundolist/src/domain/usecases/theme/update_cacahed_theme_usecase.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<InitThemeEvent>(_onInitThemeEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);

    add(const InitThemeEvent());
  }

  FutureOr<void> _onInitThemeEvent(
    InitThemeEvent event,
    Emitter<ThemeMode> emit,
  ) async {
    final themeOrError = await RestoreCachedThemeUseCase().call(
      const NoParam(),
    );

    themeOrError.fold(
      (error) {
        emit(ThemeMode.light);
      },
      (value) {
        emit(value);
      },
    );
  }

  FutureOr<void> _onChangeThemeEvent(
    ChangeThemeEvent event,
    Emitter<ThemeMode> emit,
  ) async {
    late final ThemeMode newThemeMode;

    if (state == ThemeMode.light) {
      newThemeMode = ThemeMode.dark;
    } else {
      newThemeMode = ThemeMode.light;
    }

    await UpdateCachedThemeUseCase().call(newThemeMode);
  }
}
