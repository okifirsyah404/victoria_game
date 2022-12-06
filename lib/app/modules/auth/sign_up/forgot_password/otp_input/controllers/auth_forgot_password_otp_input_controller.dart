import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class AuthForgotPasswordOtpInputController extends GetxController {
  //TODO: Implement AuthForgotPasswordOtpInputController
  final _arguments = Get.arguments;

  late UserRepository userRepository;
  late TextEditingController otpController;

  late String otp = _arguments["otp"];
  late String userMail = _arguments["email"];

  void onResendOtp() async {
    var result = await userRepository.submitForgetPassword(email: userMail);

    otp = result.data?.otp ?? "";
  }

  void onSubmitOtp() async {
    print(otp);
    print(otpController.text);
    if (otpController.text == otp) {
      Get.toNamed(Routes.AUTH_FORGOT_PASSWORD_RESET_PASSWORD, arguments: {
        "email": userMail,
      });
    } else {
      Get.dialog(const SingleActionDialog(
        title: "Kode OTP Salah",
        description: "Kode OTP yang kamu masukkan salah, coba cek lagi ya!",
      ));
    }
  }

  @override
  void onInit() {
    userRepository = UserRepository.instance;
    otpController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
