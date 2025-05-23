import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/AuthController.dart';
import '../../models/noteModel.dart';
import '../../services/database.dart';
import '../widgets/custom_icon_btn.dart';

class ShowNote extends StatefulWidget {
  final NoteModel noteData;
  final int index;
  const ShowNote({Key? key, required this.noteData, required this.index}) : super(key: key);
  @override
  State<ShowNote> createState() => _ShowNoteState();
}

class _ShowNoteState extends State<ShowNote> {
  final AuthController authController = Get.find<AuthController>();
  late final TextEditingController titleController;
  late final TextEditingController bodyController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.noteData.title);
    bodyController = TextEditingController(text: widget.noteData.body);
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(widget.noteData.creationDate.toDate());
    final time = DateFormat.jm().format(widget.noteData.creationDate.toDate());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconBtn(
                    color: Theme.of(context).colorScheme.background,
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_outlined),
                  ),
                  CustomIconBtn(
                    color: Theme.of(context).colorScheme.background,
                    onPressed: () => showDeleteDialog(context, widget.noteData),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("$formattedDate at $time"),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: titleController,
                        maxLines: null,
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
                        autofocus: true,
                        controller: bodyController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Type something...",
                        ),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (titleController.text != widget.noteData.title ||
              bodyController.text != widget.noteData.body) {
            Database().updateNote(
              authController.user!.uid,
              titleController.text,
              bodyController.text,
              widget.noteData.id,
            );
            Get.back();
          } else {
            showSameContentDialog(context);
          }
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
  void showDeleteDialog(BuildContext context, NoteModel noteData) {
    final AuthController authController = Get.find<AuthController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete Note?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            "Are you sure you want to delete this note?",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Get.back(); // Ferme la boîte de dialogue
                Database().delete(authController.user.uid, noteData.id);
                Get.back(closeOverlays: true); // Retour arrière après suppression
              },
            ),
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () => Get.back(),
            ),
          ],
        );
      },
    );
  }
  void showSameContentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "No change in content!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            "There is no change in content.",
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
}