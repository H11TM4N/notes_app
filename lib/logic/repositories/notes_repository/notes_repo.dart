import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';

class NoteRepository {
  final NotesBloc notesBloc;

  NoteRepository(this.notesBloc);

   refreshPage() {
    notesBloc.add(AppStartedEvent());
  }

  void addNote(Note note) {
    notesBloc.add(AddNewNoteEvent(note: note));
  }

  void removeNote(Note note) {
    notesBloc.add(DeleteNoteEvent(note: note));
  }

  void deleteSelectedNotes() {
    notesBloc.add(DeleteSelectedNotesEvent());
  }

  void deleteAllNotes() {
    notesBloc.add(DeleteAllNotesEvent());
  }

  void editNote(int index, Note updatedNote) {
    notesBloc.add(EditNoteEvent(index: index, updatedNote: updatedNote));
  }

  void starNote(int index) {
    notesBloc.add(StarNoteEvent(index: index));
  }

  void selectNote(int index) {
    notesBloc.add(SelectNoteEvent(index: index));
  }

  void deselectNote(int index) {
    notesBloc.add(DeSelectNoteEvent(index: index));
  }

  void clearSelection() {
    notesBloc.add(ClearSelectionEvent());
  }

  void readOnly(bool readOnly) {
    notesBloc.add(NoteIsReadOnlyEvent(readOnly: readOnly));
  }

  void notReadOnly(bool readOnly) {
    notesBloc.add(NoteNotReadOnlyEvent(readOnly: readOnly));
  }
}
