import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/note.dart';
import 'package:notes_app/logic/blocs/notes_bloc/notes_event.dart';
import 'package:notes_app/logic/blocs/notes_bloc/notes_state.dart';
import 'package:notes_app/logic/repositories/shared_preferences/notes_preferences.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState.empty()) {
    on<AppStartedEvent>(_onAppStarted);

    on<AddNewNoteEvent>(_addNewNote);

    on<DeleteNoteEvent>(_deleteNote);

    on<DeleteAllNotesEvent>(_deleteAllNotes);

    on<StarNoteEvent>(_starNote);

    on<DeleteSelectedNotesEvent>(_deleteSelectedNotes);

    on<EditNoteEvent>(_editNote);

    on<NoteNotReadOnlyEvent>(_onReadOnlyFalse);

    on<NoteIsReadOnlyEvent>(_onReadOnlyTrue);

    on<SelectNoteEvent>(_selectNote);

    on<DeSelectNoteEvent>(_deSelectNote);

    on<ClearSelectionEvent>(_clearSelection);
  }

  FutureOr<void> _starNote(event, emit) {
    emit(state.copyWith(status: NoteStatus.loading));
    if (event.index >= 0 && event.index < state.notes.length) {
      var note = state.notes[event.index];
      if (!note.isStarred) {
        note = note.copyWith(isStarred: true);
      } else {
        note = note.copyWith(isStarred: false);
      }
      List<Note>? updatedNotes = List.from(state.notes);
      updatedNotes[event.index] = note;
      emit(state.copyWith(notes: updatedNotes, status: NoteStatus.success));
    } else {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _clearSelection(event, emit) async {
    emit(state.copyWith(selectedIndices: [])); // Clear the selected indices
  }

  FutureOr<void> _deSelectNote(event, emit) {
    try {
      final selectedIndices = List<int>.from(state.selectedIndices);
      selectedIndices.remove(event.index);
      emit(state.copyWith(selectedIndices: selectedIndices));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _selectNote(event, emit) {
    try {
      if (!state.selectedIndices.contains(event.index)) {
        final selectedIndices = List<int>.from(state.selectedIndices);
        selectedIndices.add(event.index);
        emit(state.copyWith(selectedIndices: selectedIndices));
      }
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _onReadOnlyTrue(event, emit) {
    try {
      emit(state.copyWith(readOnly: true));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _onReadOnlyFalse(event, emit) {
    try {
      emit(state.copyWith(readOnly: false));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _editNote(event, emit) async {
    emit(state.copyWith(status: NoteStatus.loading));
    emit(state.copyWith(status: NoteStatus.edited));
    try {
      List<Note>? updatedNotes = List.from(state.notes);
      if (event.index >= 0 && event.index < updatedNotes.length) {
        updatedNotes[event.index] = event.updatedNote;

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
  }

  FutureOr<void> _deleteSelectedNotes(event, emit) async {
    final List<int> selectedIndices = state.selectedIndices.toList();
    List<Note> updatedNotes = List.from(state.notes);
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      // Sort the selectedIndices in descending order to avoid index shifting issues
      selectedIndices.sort((a, b) => b.compareTo(a));

      for (var index in selectedIndices) {
        updatedNotes.removeAt(index);
      }
      
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
      await NotesPreferences.saveNotesAfterDeletion(updatedNotes);
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _deleteNote(event, emit) async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      state.notes.remove(event.note);
      
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
  }

  FutureOr<void> _deleteAllNotes(event, emit) async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      state.notes.clear();
      emit(state.copyWith(
        status: NoteStatus.initial,
      ));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _addNewNote(event, emit) async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      List<Note> temp = [];
      temp.addAll(state.notes);
      temp.insert(0, event.note);
      NotesPreferences.saveNotesToPrefs(temp); //*prefs
      emit(state.copyWith(
        notes: temp,
        status: NoteStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  FutureOr<void> _onAppStarted(event, emit) async {
    emit(
      state.copyWith(status: NoteStatus.loading),
    );
    try {
      if (state.notes.isEmpty) {
        emit(
          emit(state.copyWith(
            status: NoteStatus.initial,
          )),
        );
      }
      emit(state.copyWith(
        status: NoteStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.initial));
    }
  }
}
