import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/noteModel.dart';

class ShowNote extends StatefulWidget {
  final NoteModel noteData;
  final int index;
  const ShowNote({Key? key, required this.noteData, required this.index}) : super(key: key);

}