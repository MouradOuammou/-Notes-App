import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/AuthController.dart';
import '../../controllers/UserController.dart';

class AddNotePage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
}