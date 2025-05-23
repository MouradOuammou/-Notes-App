import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/AuthController.dart';
import '../screens/auth/login.dart';
import '../screens/home/home.dart';

class Root extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("user: ${authController.user}");
      if (authController.user == null) {
        return Login(); // Affiche la page de connexion si aucun utilisateur connecté
      } else {
        return HomePage(); // Affiche la home si utilisateur connecté
      }
    });
  }
}
