import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/services/services.dart';

class NoteRepository {
  final NotesBloc notesBloc;

  NoteRepository(this.notesBloc);

  refreshPage() {
    notesBloc.add(AppStartedEvent());
  }

  void addNote(Note note) {
    notesBloc.add(AddNewNoteEvent(note: note));
    NotesPreferences.addNoteToPrefs(note);
  }

  void removeNote(Note note, int index) {
    notesBloc.add(DeleteNoteEvent(note: note));
    NotesPreferences.deleteNoteFromPrefs(index);
  }

  void deleteSelectedNotes(List<int> indicesToDelete) {
    notesBloc.add(DeleteSelectedNotesEvent());
    NotesPreferences.deleteMultipleNotes(indicesToDelete);
  }

  void deleteAllNotes() {
    notesBloc.add(DeleteAllNotesEvent());
    NotesPreferences.deleteAllNotesFromPrefs();
  }

  void editNote(int index, Note updatedNote) {
    notesBloc.add(EditNoteEvent(index: index, updatedNote: updatedNote));
    NotesPreferences.updateNoteInPrefs(index, updatedNote);
  }

  void starNote(int index) {
    notesBloc.add(StarNoteEvent(index: index));
    NotesPreferences.starNoteToggle(index);
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
