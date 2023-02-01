import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {

  ThemesBloc() : super(const ThemesState()) {

    on<ChangeThemeToOscureEvent>(_changeThemeToOscure);

  }


  Future<void> _changeThemeToOscure(ChangeThemeToOscureEvent event, Emitter<ThemesState> emit) async {
  
    return emit(state.copyWith(isOscure: event.isOscure));
  }




}
