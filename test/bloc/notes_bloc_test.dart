import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/note.dart';
import 'package:notes_app/logic/notes_bloc/notes_bloc.dart';
import 'package:notes_app/logic/notes_bloc/notes_event.dart';
import 'package:notes_app/logic/notes_bloc/notes_state.dart';

void main() {
  group('notes bloc tests', () {
    late NotesBloc notesBloc;
    late NotesState notesState;

    setUp(() {
      notesBloc = NotesBloc();
      notesState = const NotesState(
        notes: [],
        readOnly: false,
        selectedIndices: [],
        status: NoteStatus.initial,
      );
    });

    test('initial state of notesBloc is NotesState()', () {
      expect(notesBloc.state, const NotesState());
    });

    blocTest<NotesBloc, NotesState>(
      'emits [] when no event is added.',
      build: () => notesBloc,
      expect: () => [],
    );

    blocTest<NotesBloc, NotesState>(
      'emits loading, added, success when AddNewNoteEvent is added successfully',
      build: () => notesBloc,
      act: (bloc) {
        bloc.add(
            AddNewNoteEvent(note: Note(title: 'title', content: 'content')));
      },
      expect: () => [
        notesState.copyWith(status: NoteStatus.loading),
        notesState.copyWith(status: NoteStatus.added),
        notesState.copyWith(
          status: NoteStatus.success,
          notes: [Note(title: 'title', content: 'content')],
        ),
      ],
    );

    blocTest<NotesBloc, NotesState>(
      'emits loading, removed and success status when DeleteNoteEvent is added',
      build: () => notesBloc,
      seed: () => notesState
          .copyWith(notes: [Note(title: 'title', content: 'content')]),
      act: (bloc) {
        bloc.add(
          DeleteNoteEvent(note: Note(title: 'title', content: 'content')),
        );
      },
      expect: () => [
        notesState.copyWith(status: NoteStatus.loading),
        notesState.copyWith(status: NoteStatus.removed),
        notesState.copyWith(
          notes: [],
          status: NoteStatus.initial,
        ),
      ],
    );

    tearDown(() {
      notesBloc.close();
    });
  });
}
