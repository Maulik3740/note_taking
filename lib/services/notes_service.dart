import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note.dart';

class NotesService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> _notesRef(String uid) =>
      _db.collection('users').doc(uid).collection('notes');

  Stream<List<Note>> streamNotes() {
    final uid = _auth.currentUser!.uid;
    return _notesRef(uid)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((d) => Note.fromDoc(d)).toList());
  }

  Future<void> addNote(String content) async {
    final uid = _auth.currentUser!.uid;
    final now = DateTime.now();
    await _notesRef(uid).add({
      'content': content,
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  Future<void> updateNote(Note note, String newContent) async {
    final uid = _auth.currentUser!.uid;
    final now = DateTime.now();
    await _notesRef(uid).doc(note.id).update({
      'content': newContent,
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  Future<void> deleteNote(Note note) async {
    final uid = _auth.currentUser!.uid;
    await _notesRef(uid).doc(note.id).delete();
  }

  Future<void> refreshNotes() async {
    final uid = _auth.currentUser!.uid;
    await _notesRef(uid)
        .orderBy('updatedAt', descending: true)
        .get(const GetOptions(source: Source.server));
  }
}
