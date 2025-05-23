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

  /// Getter pour accéder à la liste de notes
  List<NoteModel> get notes => _noteList;

  @override
  void onInit() {
    super.onInit();
    final uid = Get.find<AuthController>().user?.uid;
    debugPrint("NoteController onInit :: $uid");

    if (uid != null) {
      _noteList.bindStream(Database().noteStream(uid));
    } else {
      debugPrint("Erreur : utilisateur non connecté");
    }
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
