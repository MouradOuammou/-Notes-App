import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

import '../models/noteModel.dart';
import '../models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String userCollection = "users";
  static const String noteCollection = "notes";

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection(userCollection).doc(user.id).set({
        "id": user.id,
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print("Erreur createNewUser: ${e.toString()}");
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
      await _firestore.collection(userCollection).doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print("Erreur getUser: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> addNote(String uid, String title, String body) async {
    try {
      String uuid = const Uuid().v4();
      await _firestore
          .collection(userCollection)
          .doc(uid)
          .collection(noteCollection)
          .doc(uuid)
          .set({
        "id": uuid,
        "title": title,
        "body": body,
        "creationDate": Timestamp.now(),
      });
    } catch (e) {
      print("Erreur addNote: ${e.toString()}");
    }
  }

  Future<void> updateNote(
      String uid, String title, String body, String id) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(uid)
          .collection(noteCollection)
          .doc(id)
          .update({
        "title": title,
        "body": body,
        "creationDate": Timestamp.now(),
      });
    } catch (e) {
      print("Erreur updateNote: ${e.toString()}");
    }
  }


}
