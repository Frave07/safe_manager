part of 'themes_bloc.dart';

abstract class ThemesEvent extends Equatable {
  const ThemesEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeToOscureEvent extends ThemesEvent {
  final bool isOscure;
  const ChangeThemeToOscureEvent(this.isOscure);
}


