import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ProfileSettingsChangePasswordOtpInputController extends GetxController {
  late SecureStorage secureStorage;
  late UserRepository userRepository;
  late TextEditingController otpController;

  String authAccessToken = "";
  String otp = "";
  String userMail = "";

  //  void onSubmitOtp() async {
  //   print(otp);
  //   print(otpController.text);
  //   if (otpController.text == otp) {
  //     Get.toNamed(Routes.AUTH_FORGOT_PASSWORD_RESET_PASSWORD, arguments: {
  //       "email": userMail,
  //     });
  //   } else {
  //     Get.dialog(const SingleActionDialog(
  //       title: "Kode OTP Salah",
  //       description: "Kode OTP yang kamu masukkan salah, coba cek lagi ya!",
  //     ));
  //   }
  // }

  // void onResendOtp() async {
  //   var result = await userRepository.submitForgetPassword(email: userMail);

  //   otp = result.data?.otp ?? "";
  // }

  void onSubmitOtp() async {
    if (otpController.text == otp) {
      Get.toNamed(Routes.PROFILE_SETTINGS_CHANGE_PASSWORD_NEW_PASSWORD_INPUT);
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
