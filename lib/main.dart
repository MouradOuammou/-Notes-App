import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/utils/root.dart';
import 'package:noteapp/utils/theme.dart';
import 'controllers/AuthController.dart';
import 'controllers/UserController.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation conditionnelle de Firebase
  if (!Platform.isLinux && !Platform.isWindows && !Platform.isMacOS) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } else {
    debugPrint(" Firebase n'est pas supporté sur cette plateforme.");
  }

  // Injection des controllers avec GetX
  Get.put<AuthController>(AuthController());
  Get.put<UserController>(UserController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Note',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeMode.system,
      home: Root(),
    );
  }
}
