import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controllers/AuthController.dart';
import '../screens/auth/login.dart';
import '../screens/home/home.dart';


class Root extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.user?.uid != null) {
        return HomePage();
      } else {
        return Login();
      }
    });
  }
}
