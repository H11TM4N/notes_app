import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/data/models/note.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(Note note) async {
    await _firestore.collection('notes').add(note.toMap());
  }

  Future<List<Note>> retrieveUserNotes(String userId) async {
    final querySnapshot = await _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.docs.map((doc) {
      return Note.fromMap(doc.data());
    }).toList();
  }
}
