import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/screens/home/show_note.dart';

import '../../controllers/AuthController.dart';
import '../../controllers/NoteController.dart';

class NoteList extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final NoteController noteController = Get.find<NoteController>();
  final List<Color> lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
  ];

  final Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (noteController.notes.isEmpty) {
        return const Expanded(
          child: Center(
            child: Text(
              "No notes yet.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        );
      }

      return Expanded(
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: noteController.notes.length,
          itemBuilder: (context, index) {
            final note = noteController.notes[index];
            final formattedDate =
            DateFormat.yMMMd().format(note.creationDate.toDate());
            final Color bg = lightColors[random.nextInt(lightColors.length)];

            return GestureDetector(
              onTap: () {
                Get.to(() => ShowNote(index: index, noteData: note));
              },
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        top: 5,
                        right: 8,
                        left: 8,
                        bottom: 0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          note.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        note.body,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formattedDate,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

    });
  }
}