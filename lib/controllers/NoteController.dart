import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/noteModel.dart';
import '../services/database.dart';
import 'AuthController.dart';

class NoteController extends GetxController {
  /// Liste observable des notes
  final RxList<NoteModel> _noteList = <NoteModel>[].obs;

  /// Contrôleurs de texte pour les champs titre et contenu
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  /// Variable pour suivre l'état de chargement
  final RxBool isLoading = false.obs;

  /// Getter pour accéder à la liste de notes
  List<NoteModel> get notes => _noteList;

  @override
  void onInit() {
    super.onInit();
    _initializeNotes();
  }

  void _initializeNotes() {
    final authController = Get.find<AuthController>();

    // Écouter les changements d'authentification
    ever(authController.firebaseUser, (User? user) {
      if (user != null) {
        debugPrint("Utilisateur connecté, chargement des notes: ${user.uid}");
        _loadUserNotes(user.uid);
      } else {
        debugPrint("Utilisateur déconnecté, vidage des notes");
        _noteList.clear();
      }
    });

    // Charger les notes si l'utilisateur est déjà connecté
    final currentUser = authController.user;
    if (currentUser != null) {
      debugPrint("Utilisateur déjà connecté: ${currentUser.uid}");
      _loadUserNotes(currentUser.uid);
    }
  }

  void _loadUserNotes(String uid) {
    isLoading.value = true;
    _noteList.bindStream(Database().noteStream(uid));
    isLoading.value = false;
  }

  /// Ajouter une nouvelle note
  Future<void> addNote() async {
    final user = Get.find<AuthController>().user;
    if (user == null) {
      Get.snackbar('Erreur', 'Utilisateur non connecté');
      return;
    }

    if (titleController.text.trim().isEmpty || bodyController.text.trim().isEmpty) {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs');
      return;
    }

    try {
      await Database().addNote(
        user.uid,
        titleController.text.trim(),
        bodyController.text.trim(),
      );
      clearForm();
      Get.back();
      Get.snackbar('Succès', 'Note ajoutée avec succès');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'ajouter la note: $e');
    }
  }

  /// Mettre à jour une note existante
  Future<void> updateNote(String noteId) async {
    final user = Get.find<AuthController>().user;
    if (user == null) {
      Get.snackbar('Erreur', 'Utilisateur non connecté');
      return;
    }

    if (titleController.text.trim().isEmpty || bodyController.text.trim().isEmpty) {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs');
      return;
    }

    try {
      await Database().updateNote(
        user.uid,
        titleController.text.trim(),
        bodyController.text.trim(),
        noteId,
      );
      clearForm();
      Get.back();
      Get.snackbar('Succès', 'Note mise à jour avec succès');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de mettre à jour la note: $e');
    }
  }

  /// Supprimer une note
  Future<void> deleteNote(String noteId) async {
    final user = Get.find<AuthController>().user;
    if (user == null) {
      Get.snackbar('Erreur', 'Utilisateur non connecté');
      return;
    }

    try {
      await Database().delete(user.uid, noteId);
      Get.snackbar('Succès', 'Note supprimée avec succès');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de supprimer la note: $e');
    }
  }

  /// Charger une note pour édition
  void loadNoteForEdit(NoteModel note) {
    titleController.text = note.title;
    bodyController.text = note.body;
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }

  void clearForm() {
    titleController.clear();
    bodyController.clear();
  }
}