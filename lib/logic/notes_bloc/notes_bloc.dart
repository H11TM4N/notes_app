import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/note.dart';
import 'package:notes_app/logic/notes_bloc/notes_event.dart';
import 'package:notes_app/logic/notes_bloc/notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<AppStartedEvent>((event, emit) async {
      emit(
        state.copyWith(status: NoteStatus.loading),
      );
      try {
        emit(state.copyWith(
          notes: [],
          status: NoteStatus.success,
        ));
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
      emit(state.copyWith(selectedIndices: [])); // Clear the selected indices
    });
  }
}
