import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../../../../global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';

class AuthSignUpController extends GetxController {
  late UserRepository _userRepository;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController usernameController;
  late TextEditingController phoneController;

  int token = 0;

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

  void signUp() async {
    if (validateSingUp()) {
      var result = await _userRepository.submitVerifySignUp(
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text,
          phone: phoneController.text);

      if (result.message != "Email already used") {
        Get.toNamed(Routes.AUTH_VERIFY_SIGN_UP, arguments: {
          "email": emailController.text,
          "username": usernameController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "otp": result.data?.otp
        });
      } else {
        Get.dialog(
          const SingleActionDialog(
            title: "Email sudah terpakai",
            description: "Coba gunakan email lain atau bisa login dulu!",
          ),
        );
      }
    }
  }

  @override
  void onInit() {
    _userRepository = UserRepository.instance;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    phoneController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
