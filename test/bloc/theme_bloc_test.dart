import 'package:bloc_test/bloc_test.dart';
import 'package:notes_app/logic/theme_bloc/theme_bloc.dart';
import 'package:notes_app/logic/theme_bloc/theme_event.dart';
import 'package:notes_app/logic/theme_bloc/theme_state.dart';
import 'package:test/test.dart';

void main() {
  group('theme bloc tests', () {
    late ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc();
    });

    test('initial state of themeBloc shoould be ThemeState(isDarkMode: false)', () {
      expect(themeBloc.state, const ThemeState(isDarkMode: false));
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits [] when nothing is added.',
      build: () => themeBloc,
      expect: () => const [],
    );
    blocTest<ThemeBloc, ThemeState>(
      'emits ThemeState(isDarkMode: true)] when MyEvent is added.',
      build: () => themeBloc,
      seed: () => const ThemeState(isDarkMode: false),
      act: (bloc) => bloc.add(const ToggleThemeEvent()),
      expect: () => const [ThemeState(isDarkMode: true)],
    );

    tearDown(
      () => themeBloc.close(),
    );
  });
}
