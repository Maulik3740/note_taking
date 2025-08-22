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
    final title = _makeTitle(content);
    await _notesRef(uid).add({
      'title': title,
      'content': content,
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  Future<void> updateNote(Note note, String newContent) async {
    final uid = _auth.currentUser!.uid;
    final now = DateTime.now();
    final title = _makeTitle(newContent);
    await _notesRef(uid).doc(note.id).update({
      'title': title,
      'content': newContent,
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  Future<void> deleteNote(Note note) async {
    final uid = _auth.currentUser!.uid;
    await _notesRef(uid).doc(note.id).delete();
  }

  String _makeTitle(String content) {
    final s = content.trim().split('\n').first;
    return s.length > 50 ? '${s.substring(0, 50)}…' : s;
  }
}
