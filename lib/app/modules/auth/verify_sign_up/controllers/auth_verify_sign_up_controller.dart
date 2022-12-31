import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class AuthVerifySignUpController extends GetxController {
  final _arguments = Get.arguments;

  late UserRepository _userRepository;
  late SecureStorage _secureStorage;

  late TextEditingController otpController;
  late CountdownTimerController countdownTimerController;

  late String otp = _arguments["otp"];
  String get userMail => _arguments["email"];
  String get username => _arguments["username"];
  String get userPassword => _arguments["password"];
  String get userPhone => _arguments["phone"];

  RxBool isResendOtp = false.obs;
  bool isOtpExpired = false;

  void onCountdownDone() {
    isResendOtp.value = true;
  }

  void onResendOtp() async {
    var result = await _userRepository.submitVerifySignUp(
      email: userMail,
      password: userPassword,
      username: username,
      phone: userPassword,
    );

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
        var userResponse = await _userRepository.submitSignUp(
          email: userMail,
          password: userPassword,
          username: username,
          phone: userPhone,
        );
        _secureStorage.writeDataToStorage(
            key: "token", value: userResponse.data?.token ?? "");
        Get.offAllNamed(Routes.MAIN_PAGE_HOME);
      }
    } else {
      Get.dialog(const SingleActionDialog(
        title: "Kode OTP Salah",
        description: "Kode OTP yang kamu masukkan salah, coba cek lagi ya!",
      ));
    }
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

  @override
  void onInit() {
    _userRepository = UserRepository.instance;
    _secureStorage = SecureStorage.instance;
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
