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

  AddNotePage({super.key});

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
              _buildHeader(context, size),
              const SizedBox(height: 20),
              // Zone de saisie du titre et du corps de la note
              _buildNoteInputFields(),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildSaveButton(context),
    );
  }

  Widget _buildHeader(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomIconBtn(
          color: Theme.of(context).colorScheme.surface,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        SizedBox(width: size.width / 4),
        Text(
          "Notes",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildNoteInputFields() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
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
            TextField(
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
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _handleSaveNote(context),
      label: const Text("Save"),
      icon: const Icon(Icons.save),
    );
  }

  void _handleSaveNote(BuildContext context) {
    if (titleController.text.trim().isEmpty && bodyController.text.trim().isEmpty) {
      _showEmptyNoteDialog(context);
    } else {
      _saveNoteToDatabase();
      Get.back();
    }
  }

  void _saveNoteToDatabase() {
    Database().addNote(
      authController.user!.uid,
      titleController.text.trim(),
      bodyController.text.trim(),
    );
  }

  void _showEmptyNoteDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(
          "Note is empty!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'The content of the note cannot be empty to be saved.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Okay",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}