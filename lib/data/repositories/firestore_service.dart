import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/data/constants/constsants.dart';
import 'package:notes_app/data/models/note.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(Note note) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Create a new note with a user-specific subcollection.
      await notesCollection.add(
        Note(
          id: user.uid,
          title: note.title,
          content: note.content,
        ).toMap(),
      );
    }
  }

  Future<void> deleteNote(Note note) async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await notesCollection
          .where(id, isEqualTo: user.uid) // Match the user's UID
          .where(title, isEqualTo: note.title)
          .where(content, isEqualTo: note.content)
          .get();

      // Check if any notes with the specified content and title were found.
      if (querySnapshot.docs.isNotEmpty) {
        // If found, delete the first one. You may need additional logic to handle multiple matches.
        await notesCollection.doc(querySnapshot.docs[0].id).delete();
      }
    }
  }

  Future<void> deleteSelectedNotes(List<Note> selectedNotes) async {
    User? user = _auth.currentUser;
    if (user != null) {
      for (Note note in selectedNotes) {
        QuerySnapshot querySnapshot = await notesCollection
            .where(id, isEqualTo: user.uid) // Match the user's UID
            .where(title, isEqualTo: note.title)
            .where(content, isEqualTo: note.content)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If found, delete the first one. You may need additional logic to handle multiple matches.
          await notesCollection.doc(querySnapshot.docs[0].id).delete();
        }
      }
    }
  }

  Future<void> updateNote(Note note, Note updatedNote) async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await notesCollection
          .where(id, isEqualTo: user.uid) // Match the user's UID
          .where(title, isEqualTo: note.title)
          .where(content, isEqualTo: note.content)
          .get();

      // Check if any notes with the specified content and title were found.
      if (querySnapshot.docs.isNotEmpty) {
        await notesCollection.doc(querySnapshot.docs[0].id).update(
              Note(
                id: user.uid,
                title: updatedNote.title,
                content: updatedNote.content,
              ).toMap(),
            );
      }
    }
  }

  Future<List<Note>> retrieveUserNotes() async {
    User? user = _auth.currentUser;

    if (user != null) {
      QuerySnapshot querySnapshot = await notesCollection
          .where(id, isEqualTo: user.uid) // Match the user's UID
          .get();

      return querySnapshot.docs.map((doc) {
        return Note.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } else {
      return [];
    }
  }
}
