import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Note(
      id: doc.id,
      title: (data['title'] as String?) ?? '',
      content: (data['content'] as String?) ?? '',
      createdAt: ((data['createdAt'] as Timestamp?) ?? Timestamp.now()).toDate(),
      updatedAt: ((data['updatedAt'] as Timestamp?) ?? Timestamp.now()).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };
}
