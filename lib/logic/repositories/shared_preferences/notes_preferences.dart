import 'dart:convert';

import 'package:notes_app/data/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPreferences {
  static late SharedPreferences _notesPrefs;

  static Future init() async =>
      _notesPrefs = await SharedPreferences.getInstance();

  static const _notesKey = 'notes';

  static Future? saveNotesToPrefs(List<Note> notes) async {
    final List<String> notesJsonList =
        notes.map((note) => note.toJson()).toList();
    await _notesPrefs.setStringList(_notesKey, notesJsonList);
  }

  static List<Note> loadNotesFromPrefs() {
    final List<String>? notesJsonList = _notesPrefs.getStringList(_notesKey);
    if (notesJsonList != null) {
      return notesJsonList.map((json) => Note.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveNotesAfterDeletion(List<Note> notes) async {
    await _notesPrefs.setStringList(
      _notesKey,
      notes.map((note) => jsonEncode(note.toJson())).toList(),
    );
  }

  static Future<void> deleteNoteFromPrefs(int index) async {
    List<Note> currentNotes = loadNotesFromPrefs();

    if (index >= 0 && index < currentNotes.length) {
      currentNotes.removeAt(index);
      await saveNotesAfterDeletion(currentNotes);
    } else {
      // Nadaaaa
    }
  }

  static Future<void> deleteMultipleNotes(List<int> indicesToDelete) async {
    List<Note> currentNotes = loadNotesFromPrefs();

    // Sort the indices in descending order to avoid index shifting issues
    indicesToDelete.sort((a, b) => b.compareTo(a));

    for (var index in indicesToDelete) {
      if (index >= 0 && index < currentNotes.length) {
        currentNotes.removeAt(index);
      } else {
        // ---------------
      }
    }
    await saveNotesAfterDeletion(currentNotes);
  }

  static Future<void> deleteAllNotesFromPrefs() async {
    await _notesPrefs.remove(_notesKey);
  }

  static Future<void> starNoteToggle(int index, bool isStarred) async {
    List<Note> currentNotes = loadNotesFromPrefs();

    if (index >= 0 && index < currentNotes.length) {
      currentNotes[index] = currentNotes[index].copyWith(isStarred: isStarred);
      await saveNotesToPrefs(currentNotes);
    } else {
      // Handle invalid index (out of bounds)
    }
  }

  static Future<void> archiveNoteToggle(int index, bool isArchived) async {
    List<Note> currentNotes = loadNotesFromPrefs();

    if (index >= 0 && index < currentNotes.length) {
      currentNotes[index] =
          currentNotes[index].copyWith(isArchived: isArchived);
      await saveNotesToPrefs(currentNotes);
    } else {
      // Handle invalid index (out of bounds)
    }
  }
}
