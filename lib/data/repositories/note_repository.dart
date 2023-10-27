import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/data/models/note.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNote(Note note) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Create a new note with a user-specific subcollection.
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('notes')
          .add(note.toMap());
    }
  }

  Future<void> deleteNote(Note note) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Delete the note from the user's specific subcollection.
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('notes')
          .doc(note.id.toString())
          .delete();
    }
  }

  Future<void> deleteSelectedNotes(List<String> selectedNoteIds) async {
    User? user = _auth.currentUser;
    if (user != null) {
      for (String noteId in selectedNoteIds) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('notes')
            .doc(noteId)
            .delete();
      }
    }
  }

  Future<void> updateNote(Note updatedNote) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('notes')
          .doc(updatedNote.id.toString())
          .update(updatedNote.toMap());
    }
  }

  Future<List<Note>> retrieveUserNotes() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final querySnapshot = await _firestore.collection('notes').get();

      return querySnapshot.docs.map((doc) {
        return Note.fromMap(doc.data());
      }).toList();
    } else {
      return [];
    }
  }
}
