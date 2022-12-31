import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class AuthForgotPasswordResetPasswordController extends GetxController {
  final _arguments = Get.arguments;

  late String userMail = _arguments["email"];

  late UserRepository _userRepository;

  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  bool validatePassword() {
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

    if (rePasswordController.text != passwordController.text) {
      Get.dialog(
        const SingleActionDialog(
          title: "Ulangi Password tidak sama",
          description:
              "Kedua password yang kamu masukkan tidak sama! Nanti gampang lupa lagi.",
        ),
      );
      return false;
    }

    return true;
  }

  onSubmitUpdatePassword() async {
    if (validatePassword()) {
      await _userRepository.submitNewForgetPassword(
        email: userMail,
        newPassword: passwordController.text,
      );
      Get.offNamedUntil(Routes.AUTH_SIGN_IN, (route) => route.isFirst);
    }
  }

  @override
  void onInit() {
    _userRepository = UserRepository.instance;
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }
}
