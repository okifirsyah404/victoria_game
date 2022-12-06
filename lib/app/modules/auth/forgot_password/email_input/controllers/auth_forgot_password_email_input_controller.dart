import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class AuthForgotPasswordEmailInputController extends GetxController {
  late UserRepository userRepository;
  late TextEditingController emailController;

  bool validateEmail() {
    if (emailController.text.isEmpty) {
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

  void onSubmitEmail() async {
    if (validateEmail()) {
      var result = await userRepository.submitForgetPassword(
          email: emailController.text);

      if (result.message != "Email not registered") {
        Get.toNamed(Routes.AUTH_FORGOT_PASSWORD_OTP_INPUT, arguments: {
          "otp": result.data?.otp,
          "email": emailController.text,
        });
      } else {
        Get.dialog(
          const SingleActionDialog(
            title: "Email Kamu Belum Terdaftar",
            description:
                "Kamu mungkin salah memasukkan Email, Coba cek lagi ya! Atau bisa daftar aja",
          ),
        );
      }
    }
  }

  @override
  void onInit() {
    userRepository = UserRepository.instance;
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
