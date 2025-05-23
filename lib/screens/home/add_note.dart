import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/AuthController.dart';
import '../../controllers/UserController.dart';
import '../../services/database.dart';
import '../widgets/custom_icon_btn.dart';

class AddNotePage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
        child: Container(
        height: size.height,
        padding: const EdgeInsets.all(16.0),
    child: Column(
    children: <Widget>[
    // En-tête avec bouton retour et titre
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    CustomIconBtn(
    color: Theme.of(context).colorScheme.background,
    onPressed: () => Get.back(),
    icon: const Icon(Icons.arrow_back_ios_outlined),
    ),
    SizedBox(width: size.width / 4),
    const Text(
    "Notes",
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    const SizedBox(height: 20),

    // Zone de saisie du titre et du corps de la note
    Expanded(
    child: SingleChildScrollView(
    child: Column(
    children: [
    TextFormField(
    maxLines: null,
    autofocus: true,
    controller: titleController,
    keyboardType: TextInputType.multiline,
    textCapitalization: TextCapitalization.sentences,
    decoration: const InputDecoration.collapsed(
    hintText: "Title",
    ),
    style: const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w500,
    ),
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: bodyController,
    keyboardType: TextInputType.multiline,
    maxLines: null,
    textCapitalization: TextCapitalization.sentences,
    decoration: const InputDecoration.collapsed(
    hintText: "Type something...",
    ),
    style: const TextStyle(
    fontSize: 20.0,
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ),
        // Bouton flottant "Save" pour enregistrer la note
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
      // On empêche d'ajouter une note si titre ET corps sont vides
      if (titleController.text.trim().isEmpty &&
          bodyController.text.trim().isEmpty) {
        showEmptyTitleDialog(context);
      } else {
        // Ajout de la note à la base de données
        Database().addNote(
          authController.user!.uid,
          titleController.text.trim(),
          bodyController.text.trim(),
        );
        Get.back();
      }
    },
    label: const Text("Save"),
    icon: const Icon(Icons.save),
    ),
    );
  }
}
void showEmptyTitleDialog(BuildContext context) {
  print("Showing empty note dialog");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Text(
          "Notes is empty!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'The content of the note cannot be empty to be saved.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Okay",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      );
    },
  );
}