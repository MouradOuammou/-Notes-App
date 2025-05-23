import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/AuthController.dart';
import '../../controllers/UserController.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  Widget _buildFormField({
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isPassword = false,
    required BuildContext context,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  void _showSuccessSnackbar() {
    Get.snackbar(
      'Succès!',
      'Compte créé avec succès!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      animationDuration: Duration(milliseconds: 500),
      icon: Icon(Icons.check_circle, color: Colors.white),
      shouldIconPulse: true,
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Get Started!',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  _buildFormField(
                    hint: "NAME",
                    controller: authController.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a username!';
                      } else if (value.length < 6) {
                        return "Username must be at least 6 characters";
                      }
                      return null;
                    },
                    context: context,
                  ),
                  SizedBox(height: 30),
                  _buildFormField(
                    hint: "EMAIL",
                    controller: authController.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your email!";
                      }
                      return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                          .hasMatch(value)
                          ? null
                          : "Invalid email format";
                    },
                    context: context,
                  ),
                  SizedBox(height: 30),
                  _buildFormField(
                    hint: "PASSWORD",
                    controller: authController.password,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a password!';
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    context: context,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.shade700,
                      padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(250, 50),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          await authController.createUser();
                          _showSuccessSnackbar();
                          // Optionnel: Naviguer vers une autre page après un délai
                          // Future.delayed(Duration(seconds: 3), () => Get.offAll(HomePage()));
                        } catch (e) {
                          Get.snackbar(
                            'Erreur',
                            'Échec de la création du compte',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.shade600,
                            colorText: Colors.white,
                          );
                        }
                      }
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member? ",
                          style: TextStyle(fontSize: 16)),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}