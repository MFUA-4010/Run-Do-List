part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class InitThemeEvent extends ThemeEvent {
  const InitThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  const ChangeThemeEvent();
}
