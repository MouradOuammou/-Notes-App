import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

}