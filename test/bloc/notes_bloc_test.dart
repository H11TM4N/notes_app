import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() async {
  group('NotesBloc Tests', () {
    late NotesBloc notesBloc;
    SharedPreferences prefs;

    // Set up the bloc and shared preferences before running any tests.
    setUpAll(() async {
      prefs = await SharedPreferences.getInstance();
      notesBloc = NotesBloc(prefs: prefs);
    });

    test('Initial state of NotesBloc is NotesState()', () {
      expect(notesBloc.state, const NotesState());
    });

    blocTest(
      'description',
      build: () => notesBloc,
      act: (bloc) {},
      expect: () {},
    );

    blocTest(
      'description',
      build: () => notesBloc,
      act: (bloc) {},
      expect: () {},
    );

    blocTest(
      'description',
      build: () => notesBloc,
      act: (bloc) {},
      expect: () {},
    );

    // Dispose of resources when tests are done.
    tearDown(() {
      notesBloc.close();
    });
  });
}
