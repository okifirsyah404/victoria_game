import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ProfileSettingsChangePasswordNewPasswordInputController
    extends GetxController {
  late SecureStorage secureStorage;
  late UserRepository userRepository;

  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  String authAccessToken = "";

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
      await userRepository.submitResetPassword(
          authToken: authAccessToken, newPassword: passwordController.text);
      Get.offNamedUntil(
          Routes.PROFILE_SETTINGS_USER_PROFILE, (route) => route.isFirst);
    }
  }

  Future<void> onUserDataInit() async {
    authAccessToken = await secureStorage.readDataFromStrorage("token") ?? "";
  }

  @override
  void onInit() {
    secureStorage = SecureStorage.instance;
    userRepository = UserRepository.instance;
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    onUserDataInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }
}
