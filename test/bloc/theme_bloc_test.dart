import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/logic/blocs/theme_bloc/theme_bloc.dart';
import 'package:notes_app/logic/blocs/theme_bloc/theme_event.dart';
import 'package:notes_app/logic/blocs/theme_bloc/theme_state.dart';

void main() {
  group('ThemeBloc tests', () {
    late ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc();
    });

    tearDownAll(() {
      themeBloc.close();
    });

    test('initial state of themeBloc should be ThemeState(isDarkMode: false)', () {
      expect(themeBloc.state, const ThemeState(isDarkMode: false));
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits [] when nothing is added.',
      build: () => themeBloc,
      expect: () => const [],
    );

    blocTest<ThemeBloc, ThemeState>(
      'emits ThemeState(isDarkMode: true) when ToggleThemeEvent is added.',
      build: () => themeBloc,
      seed: () => const ThemeState(isDarkMode: false),
      act: (bloc) => bloc.add(const ToggleThemeEvent()),
      expect: () => const [ThemeState(isDarkMode: true)],
    );

    // Add more tests as needed
  });
}
