import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/AuthController.dart';
import '../../controllers/UserController.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required IconData icon,
    bool isPassword = false,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  void _showSuccessSnackbar() {
    Get.snackbar(
      'Succès !',
      'Compte créé avec succès !',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      animationDuration: const Duration(milliseconds: 500),
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
      shouldIconPulse: true,
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          color: Colors.green.withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Icône d'inscription
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Titre
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Créer un compte',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rejoignez-nous dès maintenant !',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Formulaire dans une carte
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          _buildFormField(
                            label: "Nom d'utilisateur",
                            hint: "Votre nom d'utilisateur",
                            icon: Icons.person_outline,
                            controller: authController.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entrez un nom d'utilisateur !";
                              } else if (value.length < 3) {
                                return "Le nom doit contenir au moins 3 caractères";
                              }
                              return null;
                            },
                            context: context,
                          ),

                          _buildFormField(
                            label: "Email",
                            hint: "votre@email.com",
                            icon: Icons.email_outlined,
                            controller: authController.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entrez votre email !";
                              }
                              return RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$")
                                  .hasMatch(value)
                                  ? null
                                  : "Format d'email invalide";
                            },
                            context: context,
                          ),

                          _buildFormField(
                            label: "Mot de passe",
                            hint: "••••••••",
                            icon: Icons.lock_outline,
                            controller: authController.password,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez un mot de passe !';
                              } else if (value.length < 6) {
                                return "Le mot de passe doit contenir au moins 6 caractères";
                              }
                              return null;
                            },
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Bouton d'inscription
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await authController.createUser();
                            _showSuccessSnackbar();
                          } catch (e) {
                            Get.snackbar(
                              'Erreur',
                              'Échec de la création du compte',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red.shade600,
                              colorText: Colors.white,
                              borderRadius: 16,
                              margin: const EdgeInsets.all(16),
                            );
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Créer mon compte",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Lien de connexion
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Déjà membre ? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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