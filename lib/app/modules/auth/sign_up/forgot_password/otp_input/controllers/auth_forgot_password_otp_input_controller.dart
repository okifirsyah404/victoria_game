import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class AuthForgotPasswordOtpInputController extends GetxController {
  //TODO: Implement AuthForgotPasswordOtpInputController
  final _arguments = Get.arguments;

  late UserRepository _userRepository;
  late TextEditingController otpController;
  late CountdownTimerController countdownTimerController;

  late String otp = _arguments["otp"];
  late String userMail = _arguments["email"];

  RxBool isResendOtp = false.obs;
  bool isOtpExpired = false;

  void onCountdownDone() {
    isResendOtp.value = true;
  }

  setExpiresOtp() async {
    const duration = Duration(minutes: 5);

    return Timer(
      duration,
      () {
        isOtpExpired = true;
      },
    );
  }

  void onResendOtp() async {
    var result = await _userRepository.submitForgetPassword(email: userMail);

    otp = result.data?.otp ?? "";

    isOtpExpired = false;
    setExpiresOtp();
    isResendOtp.value = false;
  }

  void onSubmitOtp() async {
    if (otpController.text == otp) {
      if (isOtpExpired) {
        Get.dialog(const SingleActionDialog(
          title: "Kode OTP Kadaluarsa",
          description:
              "Kode OTP yang kamu masukkan sudah kadaluarsa, coba lagi ya!",
        ));
      } else {
        Get.toNamed(Routes.AUTH_FORGOT_PASSWORD_RESET_PASSWORD, arguments: {
          "email": userMail,
        });
      }
    } else {
      Get.dialog(const SingleActionDialog(
        title: "Kode OTP Salah",
        description: "Kode OTP yang kamu masukkan salah, coba cek lagi ya!",
      ));
    }
  }

  @override
  void onInit() {
    _userRepository = UserRepository.instance;
    otpController = TextEditingController();
    countdownTimerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 2,
    );
    setExpiresOtp();
    super.onInit();
  }

  @override
  void onClose() {
    otpController.dispose();
    countdownTimerController.dispose();
    super.onClose();
  }
}
