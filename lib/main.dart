import 'package:flutter/foundation.dart' show kIsWeb;
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

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.web,
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
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
