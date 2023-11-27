import 'package:bloc_test/bloc_test.dart';
import 'package:notes_app/logic/theme_bloc/theme_bloc.dart';
import 'package:notes_app/logic/theme_bloc/theme_event.dart';
import 'package:notes_app/logic/theme_bloc/theme_state.dart';
import 'package:test/test.dart';

void main() {
  group('theme bloc tests', () {
    blocTest<ThemeBloc, ThemeState>(
      'emits [] when nothing is added.',
      build: () => ThemeBloc(),
      expect: () => const [],
    );
    blocTest<ThemeBloc, ThemeState>(
      'emits ThemeState(isDarkMode: true)] when MyEvent is added.',
      build: () => ThemeBloc(),
      seed: () => const ThemeState(isDarkMode: false),
      act: (bloc) => bloc.add(const ToggleThemeEvent()),
      expect: () => const [ThemeState(isDarkMode: true)],
    );
  });
}
