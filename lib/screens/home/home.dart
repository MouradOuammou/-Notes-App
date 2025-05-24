import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/AuthController.dart';
import '../../controllers/NoteController.dart';
import '../settings/Setting.dart';
import '../widgets/custom_icon_btn.dart';
import 'add_note.dart';
import 'note_list.dart';

class HomePage extends GetWidget<AuthController> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Obx(() =>
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Bouton pour basculer s affichage liste et grille
                      CustomIconBtn(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .surface,
                        onPressed: () {
                          // Change la valeur de axisCount entre 2 et 4
                          authController.axisCount.value =
                          authController.axisCount.value == 2 ? 4 : 2;
                        },
                        icon: Icon(authController.axisCount.value == 2
                            ? Icons.list
                            : Icons.grid_on),
                      ),

                      // Titre de la page
                      const Text(
                        "Notes",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Bouton paramètres
                      CustomIconBtn(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .surface,
                        onPressed: () {
                          Get.to(() => Setting());
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Affiche la liste des notes
                  GetX<NoteController>(
                    init: Get.put(NoteController()),
                    builder: (NoteController noteController) {
                      if (noteController.notes.isNotEmpty) {
                        return NoteList();
                      } else {
                        return const Text("No notes, create some");
                      }
                    },
                  ),
                ],
              )),
        ),
      ),
      // Bouton flottant pour ajouter une nouvelle note
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Note",
        onPressed: () {
          Get.to(() => AddNotePage());
        },
        child: const Icon(Icons.note_add, size: 30),
      ),
    );
  }
}