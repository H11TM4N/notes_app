import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/repositories/repos.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.empty()) {
    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(isDarkMode: !state.isDarkMode));
      ThemePreferences.saveTheme(state.isDarkMode);
    });
  }
}
