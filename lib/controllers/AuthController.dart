import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/controllers/userController.dart';
import 'package:flutter_note/models/user.dart';
import 'package:flutter_note/services/database.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Rx<User?> _firebaseUser;

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final String usersCollection = "users";

  final Rx<UserModel> userModel = UserModel().obs;
  final Rx<int> axisCount = 2.obs;

  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
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
      print("Logging in with email: ${email.text}, password: ${password.text}");

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final loggedUser = userCredential.user;
      if (loggedUser != null) {
        final fetchedUser = await Database().getUser(loggedUser.uid);
        Get.find<UserController>().user = fetchedUser;
        _clearControllers();
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
      Get.find<UserController>().user = UserModel();
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
}
