import 'package:notes_app/data/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPreferences {
  static late SharedPreferences _notesPrefs;

  static Future init() async =>
      _notesPrefs = await SharedPreferences.getInstance();

  static const _notesKey = 'notes';
  static const _isStarredKey = 'isStarred';
  static const _isArchivedKey = 'isArchived';

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

  static Future? saveStarredStatus(bool isStarred) async {
    await _notesPrefs.setBool(_isStarredKey, isStarred);
  }

  static bool? loadStarredStatus() {
    return _notesPrefs.getBool(_isStarredKey);
  }

  static Future? saveArchivedStatus(bool isArchived) async {
    await _notesPrefs.setBool(_isArchivedKey, isArchived);
  }

  static bool? loadArchivedStatus() {
    return _notesPrefs.getBool(_isArchivedKey);
  }
}
