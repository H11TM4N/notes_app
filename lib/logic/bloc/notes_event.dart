import 'package:equatable/equatable.dart';
import 'package:notes_app/data/models/note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class AppStartedEvent extends NotesEvent {}

class AddNewNoteEvent extends NotesEvent {
  final Note note;

  const AddNewNoteEvent({required this.note});

  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NotesEvent {
  final Note note;

  const DeleteNoteEvent({required this.note});

  @override
  List<Object?> get props => [note];
}

class DeleteSelectedNotesEvent extends NotesEvent {}

class EditNoteEvent extends NotesEvent {
  final int index;
  final Note updatedNote;

  const EditNoteEvent({required this.index, required this.updatedNote});

  @override
  List<Object?> get props => [index, updatedNote];
}

class NoteIsReadOnlyEvent extends NotesEvent {
  final bool readOnly;

  const NoteIsReadOnlyEvent({required this.readOnly});

  @override
  List<Object?> get props => [readOnly];
}

class NoteNotReadOnlyEvent extends NotesEvent {
  final bool readOnly;

  const NoteNotReadOnlyEvent({required this.readOnly});

  @override
  List<Object?> get props => [readOnly];
}

class SelectNoteEvent extends NotesEvent {
  final int index;

  const SelectNoteEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class DeSelectNoteEvent extends NotesEvent {
  final int index;

  const DeSelectNoteEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class ClearSelectionEvent extends NotesEvent {}
