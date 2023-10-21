import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/note.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final SharedPreferences prefs;
  NotesBloc({required this.prefs}) : super(const NotesState()) {
    on<AppStartedEvent>((event, emit) async {
      emit(
        state.copyWith(status: NoteStatus.loading),
      );
      try {
        final List<Note> notes = await loadNotesFromPrefs();
        if (notes.isEmpty) {
          emit(state.copyWith(
            notes: notes,
            status: NoteStatus.initial,
          ));
        } else {
          emit(state.copyWith(
            notes: notes,
            status: NoteStatus.success,
          ));
        }
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<AddNewNoteEvent>((event, emit) async {
      emit(
        state.copyWith(status: NoteStatus.loading),
      );
      try {
        List<Note> temp = [];
        temp.addAll(state.notes);
        temp.insert(0, event.note);

        await saveNotesToPrefs(temp);

        emit(state.copyWith(
          notes: temp,
          status: NoteStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      emit(
        state.copyWith(status: NoteStatus.loading),
      );
      try {
        state.notes.remove(event.note);

        await saveNotesToPrefs(state.notes);
        if (state.notes.isEmpty) {
          emit(state.copyWith(
            status: NoteStatus.initial,
          ));
        } else {
          emit(state.copyWith(
            notes: state.notes,
            status: NoteStatus.success,
          ));
        }
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<DeleteSelectedNotesEvent>((event, emit) async {
      final List<int> selectedIndices = state.selectedIndices.toList();
      List<Note> updatedNotes = List.from(state.notes);

      try {
        // Sort the selectedIndices in descending order to avoid index shifting issues
        selectedIndices.sort((a, b) => b.compareTo(a));

        for (var index in selectedIndices) {
          updatedNotes.removeAt(index);
        }
        await saveNotesToPrefs(updatedNotes);

        if (updatedNotes.isEmpty) {
          emit(state.copyWith(
            notes: updatedNotes,
            selectedIndices: [],
            status: NoteStatus.initial,
          ));
        } else {
          emit(state.copyWith(
            notes: updatedNotes,
            selectedIndices: [],
            status: NoteStatus.success,
          ));
        }
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<EditNoteEvent>((event, emit) async {
      emit(state.copyWith(status: NoteStatus.loading));
      try {
        List<Note>? updatedNotes = List.from(state.notes);
        if (event.index >= 0 && event.index < updatedNotes.length) {
          updatedNotes[event.index] = event.updatedNote;
          await saveNotesToPrefs(state.notes);
          emit(state.copyWith(
            notes: updatedNotes,
            status: NoteStatus.success,
          ));
        } else {
          emit(state.copyWith(
            status: NoteStatus.error,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: NoteStatus.error,
        ));
      }
    });

    on<NoteNotReadOnlyEvent>((event, emit) {
      try {
        emit(state.copyWith(readOnly: false));
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<NoteIsReadOnlyEvent>((event, emit) {
      try {
        emit(state.copyWith(readOnly: true));
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<SelectNoteEvent>((event, emit) {
      try {
        if (!state.selectedIndices.contains(event.index)) {
          final selectedIndices = List<int>.from(state.selectedIndices);
          selectedIndices.add(event.index);
          emit(state.copyWith(selectedIndices: selectedIndices));
        }
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<DeSelectNoteEvent>((event, emit) {
      try {
        final selectedIndices = List<int>.from(state.selectedIndices);
        selectedIndices.remove(event.index);
        emit(state.copyWith(selectedIndices: selectedIndices));
      } catch (e) {
        emit(state.copyWith(status: NoteStatus.error));
      }
    });

    on<ClearSelectionEvent>((event, emit) async {
      await saveNotesToPrefs(state.notes);
      emit(state.copyWith(selectedIndices: [])); // Clear the selected indices
    });
  }

  // ... Save and load functions ...

  Future<void> saveNotesToPrefs(List<Note> notes) async {
    final List<String> notesJsonList =
        notes.map((note) => note.toJson()).toList();
    await prefs.setStringList('notes', notesJsonList);
  }

  Future<List<Note>> loadNotesFromPrefs() async {
    final List<String>? notesJsonList = prefs.getStringList('notes');
    if (notesJsonList != null) {
      return notesJsonList.map((json) => Note.fromJson(json)).toList();
    }
    return [];
  }
}
