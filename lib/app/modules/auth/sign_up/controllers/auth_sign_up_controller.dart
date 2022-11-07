import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../../../../core/services/firebase_auth_services.dart';
import '../../../../global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';

class AuthSignUpController extends GetxController {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController usernameController;

  bool validateSingUp() {
    if (usernameController.text.isEmpty) {
      Get.dialog(
        const SingleActionDialog(
          title: "Username tidak boleh kosong",
          description: "Tolong masukkan username kamu ya!",
        ),
      );
      return false;
    }

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
          title: "Password tidak boleh kosong",
          description:
              "Tolong masukkan password kamu ya! Demi keamanan akun kamu nih.",
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

    if (passwordController.text.length < 8) {
      Get.dialog(
        const SingleActionDialog(
          title: "Password kamu lemah",
          description:
              "Password kamu kurang dari 8 digit nih, nanti mudah ditebak!",
        ),
      );
      return false;
    }

    if (!passwordController.text.contains(
      RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}'),
    )) {
      Get.dialog(
        const SingleActionDialog(
          title: "Password kamu lemah",
          description:
              "Password kamu seharusnya ada huruf dan angka, nanti mudah ditebak!",
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
    usernameController = TextEditingController();
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
    usernameController.dispose();
    super.onClose();
  }

  void signUp() {
    if (validateSingUp()) {
      firebaseAuthServices.createUserPasswordBased(
        emailAddress: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        route: Routes.MAIN_PAGE_HOME,
      );
    }
  }
}
