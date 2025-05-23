import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String body;
  final Timestamp creationDate;

  NoteModel({
    required this.id,
    required this.title,
    required this.body,
    required this.creationDate,
  });

  factory NoteModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return NoteModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      creationDate: data['creationDate'] ?? Timestamp.now(),
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      creationDate: json['creationDate'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'creationDate': creationDate,
    };
  }
}
