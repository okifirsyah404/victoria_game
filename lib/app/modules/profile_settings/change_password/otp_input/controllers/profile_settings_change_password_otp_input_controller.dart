import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ProfileSettingsChangePasswordOtpInputController extends GetxController {
  late SecureStorage secureStorage;
  late UserRepository userRepository;
  late TextEditingController otpController;
  late CountdownTimerController countdownTimerController;

  String authAccessToken = "";
  String otp = "";
  String userMail = "";

  RxBool isResendOtp = false.obs;
  bool isOtpExpired = false;

  void onCountdownDone() {
    isResendOtp.value = true;
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
        Get.toNamed(Routes.PROFILE_SETTINGS_CHANGE_PASSWORD_NEW_PASSWORD_INPUT);
      }
    } else {
      Get.dialog(
        const SingleActionDialog(
          title: "Kode OTP Salah",
          description: "Kode OTP yang kamu masukkan salah, coba cek lagi ya!",
        ),
      );
    }
  }

  void onResendOtp() async {
    var result =
        await userRepository.submitResetOtpPassword(authToken: authAccessToken);

    otp = result.data?.otp ?? "";

    isOtpExpired = false;
    setExpiresOtp();
    isResendOtp.value = false;
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

  Future<void> onUserDataInit() async {
    var authToken = await secureStorage.readDataFromStrorage("token") ?? "";

    var userDataResult = await userRepository.fetchUserData(authToken);
    var result =
        await userRepository.submitResetOtpPassword(authToken: authToken);

    otp = result.data?.otp ?? "";
    userMail = userDataResult.data?.email ?? "";
    authAccessToken = authToken;
  }

  @override
  void onInit() {
    secureStorage = SecureStorage.instance;
    userRepository = UserRepository.instance;
    otpController = TextEditingController();
    countdownTimerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 2,
    );
    setExpiresOtp();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    otpController.dispose();
    countdownTimerController.dispose();
    super.onClose();
  }
}
