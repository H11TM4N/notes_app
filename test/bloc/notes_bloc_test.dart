import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/note.dart';

import 'package:notes_app/logic/notes_bloc/notes_bloc.dart';
import 'package:notes_app/logic/notes_bloc/notes_event.dart';
import 'package:notes_app/logic/notes_bloc/notes_state.dart';

void main() {
  group('NotesBloc', () {
    late NotesBloc notesBloc;

    setUp(() {
      notesBloc = NotesBloc();
    });

    tearDown(() {
      notesBloc.close();
    });

    blocTest<NotesBloc, NotesState>(
      'emits NotesState with loading and success when AppStartedEvent is added',
      build: () => notesBloc,
      act: (bloc) => bloc.add(AppStartedEvent()),
      expect: () => [
        const NotesState(status: NoteStatus.loading),
        const NotesState(notes: [], status: NoteStatus.success),
      ],
    );

    blocTest<NotesBloc, NotesState>(
      'emits NotesState with loading and added when AddNewNoteEvent is added',
      build: () => notesBloc,
      act: (bloc) =>
          bloc.add(AddNewNoteEvent(note: Note(content: '', title: '', id: ''))),
      expect: () => [
        const NotesState(status: NoteStatus.loading),
        const NotesState(status: NoteStatus.added),
        const NotesState(
            notes: [/* assert that the note you added is here */],
            status: NoteStatus.success),
      ],
    );

    // Add more tests for other events and scenarios
  });
}
