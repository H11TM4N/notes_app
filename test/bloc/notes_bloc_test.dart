// import 'package:flutter/widgets.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:notes_app/data/repositories/shared_prefs_repo.dart';
// import 'package:notes_app/logic/bloc/notes_bloc.dart';
// import 'package:notes_app/logic/bloc/notes_state.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bloc_test/bloc_test.dart';

// void main() {
//   group('NotesBloc Tests', () {
//     late NotesBloc notesBloc;
//     late SharedPreferencesRepository sharedPreferencesRepository;
//     late SharedPreferences prefs;

//     // Wrap your test setup inside `testWidgets` and provide the async callback.
//     testWidgets('Initialize NotesBloc and SharedPreferences', (WidgetTester tester) async {
//       WidgetsFlutterBinding.ensureInitialized(); // EnsureInitialized within testWidgets

//       prefs = await SharedPreferences.getInstance();
//       sharedPreferencesRepository = SharedPreferencesRepository(prefs);
//       notesBloc = NotesBloc(sharedPreferencesRepository: sharedPreferencesRepository);
//     });

//     test('Initial state of NotesBloc is NotesState()', () {
//       expect(notesBloc.state, const NotesState());
//     });

//     blocTest(
//       'description',
//       build: () => notesBloc,
//       act: (bloc) {},
//       expect: () {},
//     );

//     blocTest(
//       'description',
//       build: () => notesBloc,
//       act: (bloc) {},
//       expect: () {},
//     );

//     blocTest(
//       'description',
//       build: () => notesBloc,
//       act: (bloc) {},
//       expect: () {},
//     );

//     // Dispose of resources when tests are done.
//     tearDown(() {
//       notesBloc.close();
//     });
//   });
// }
