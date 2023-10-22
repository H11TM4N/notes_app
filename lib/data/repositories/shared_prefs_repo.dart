import 'package:notes_app/data/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  final SharedPreferences prefs;

  SharedPreferencesRepository(this.prefs);

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
