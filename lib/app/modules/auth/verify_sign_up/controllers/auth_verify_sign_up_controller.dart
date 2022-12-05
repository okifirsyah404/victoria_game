import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class AuthVerifySignUpController extends GetxController {
  var _arguments = Get.arguments;

  late UserRepository userRepository;
  late SecureStorage secureStorage;

  late TextEditingController otpController;

  String get otp => _arguments["otp"];
  String get userMail => _arguments["email"];

  void onSubmitOtp() async {
    if (otpController.text == otp) {
      var userResponse = await userRepository.submitSignUp(
        email: _arguments["email"],
        password: _arguments["password"],
        username: _arguments["username"],
        phone: _arguments["phone"],
      );
      var putToStorage = secureStorage.writeDataToStorage(
          key: "token", value: userResponse.data?.token ?? "");
      Get.offAllNamed(Routes.MAIN_PAGE_HOME);
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
    secureStorage = SecureStorage.instance;
    otpController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
