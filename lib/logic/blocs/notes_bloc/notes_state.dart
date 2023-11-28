// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/note.dart';

class NotesState extends Equatable {
  final List<Note> notes;
  final NoteStatus status;
  final bool readOnly;
  final List<int> selectedIndices;

  const NotesState({
    this.notes = const <Note>[],
    this.status = NoteStatus.initial,
    this.readOnly = false,
    this.selectedIndices = const <int>[],
  });

  @override
  List<Object?> get props => [notes, status, readOnly, selectedIndices];

  NotesState copyWith({
    List<Note>? notes,
    NoteStatus? status,
    bool? readOnly,
    List<int>? selectedIndices,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
      readOnly: readOnly ?? this.readOnly,
      selectedIndices: selectedIndices ?? this.selectedIndices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notes': notes.map((x) => x.toMap()).toList(),
      'status': status.toString(),
      'readOnly': readOnly,
      'selectedIndices': selectedIndices,
    };
  }

  factory NotesState.fromMap(Map<String, dynamic> map) {
    return NotesState(
      notes: List<Note>.from(
        (map['notes'] as List<int>).map<Note>(
          (x) => Note.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: NoteStatus.values.firstWhere((status) => status == map['status'],
          orElse: () => NoteStatus.initial),
      readOnly: map['readOnly'] as bool,
      selectedIndices: List<int>.from(
        (map['selectedIndices'] as List<int>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesState.fromJson(String source) =>
      NotesState.fromMap(json.decode(source) as Map<String, dynamic>);
}
