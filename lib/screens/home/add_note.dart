import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/AuthController.dart';
import '../../controllers/UserController.dart';

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
    )

}