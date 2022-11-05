import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/services/firebase_auth_services.dart';

class AuthSignInController extends GetxController {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void signIn() {
    firebaseAuthServices.signInUserPasswordBased(
        emailAddress: emailController.text, password: passwordController.text);
  }
}
