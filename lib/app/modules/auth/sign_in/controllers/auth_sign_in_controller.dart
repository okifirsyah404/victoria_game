import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/services/firebase_auth_services.dart';

import '../../../../global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import '../../../../routes/app_pages.dart';

class AuthSignInController extends GetxController {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool validateSingIn() {
    if (emailController.text.isEmpty) {
      Get.dialog(
        const SingleActionDialog(
          title: "Email tidak boleh kosong",
          description: "Tolong masukkan email kamu ya!",
        ),
      );
      return false;
    }

    if (passwordController.text.isEmpty) {
      Get.dialog(
        const SingleActionDialog(
          title: "Email tidak boleh kosong",
          description: "Tolong masukkan email kamu ya!",
        ),
      );
      return false;
    }

    if (!emailController.text.isEmail) {
      Get.dialog(
        const SingleActionDialog(
          title: "Email tidak valid",
          description:
              "Email yang kamu masukan tidak valid, tolong dicek lagi ya!",
        ),
      );
      return false;
    }

    return true;
  }

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
    if (validateSingIn()) {
      firebaseAuthServices.signInUserPasswordBased(
        emailAddress: emailController.text,
        password: passwordController.text,
        route: Routes.HOME,
      );
    }
  }
}
