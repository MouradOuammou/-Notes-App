import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../services/database.dart';
import 'UserController.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Rx<User?> _firebaseUser;

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final String usersCollection = "users";

  final Rx<UserModel> userModel = UserModel(id: '', name: '', email: '').obs;
  final Rx<int> axisCount = 2.obs;

  User? get user => _firebaseUser.value;

  // Getter public pour accéder à _firebaseUser depuis NoteController
  Rx<User?> get firebaseUser => _firebaseUser;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());

    // Écouter les changements d'authentification
    ever(_firebaseUser, _handleAuthStateChange);
  }

  void _handleAuthStateChange(User? user) {
    if (user != null) {
      debugPrint("Utilisateur connecté: ${user.uid}");
      _loadUserData(user.uid);
    } else {
      debugPrint("Utilisateur déconnecté");
      Get.find<UserController>().user = UserModel(id: '', name: '', email: '');
    }
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final fetchedUser = await Database().getUser(uid);
      Get.find<UserController>().user = fetchedUser;
    } catch (e) {
      debugPrint("Erreur lors du chargement des données utilisateur: $e");
    }
  }

  Future<void> createUser() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        final newUser = UserModel(
          id: user.uid,
          name: name.text,
          email: email.text,
        );

        final success = await Database().createNewUser(newUser);
        if (success) {
          Get.find<UserController>().user = newUser;
          Get.back();
          _clearControllers();
          Get.snackbar('Succès', 'Compte créé avec succès');
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error creating account',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> login() async {
    try {
      debugPrint("Logging in with email: ${email.text}");

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final loggedUser = userCredential.user;
      if (loggedUser != null) {
        // Les données utilisateur seront chargées automatiquement via _handleAuthStateChange
        _clearControllers();
        Get.snackbar('Succès', 'Connexion réussie');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error logging in',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error logging in',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // Le nettoyage des données sera fait automatiquement via _handleAuthStateChange
      Get.snackbar('Succès', 'Déconnexion réussie');
    } catch (e) {
      Get.snackbar(
        'Error signing out',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }
}