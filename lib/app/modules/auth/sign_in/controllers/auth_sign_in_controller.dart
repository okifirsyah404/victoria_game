import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/core/services/firebase_auth_services.dart';
import 'package:victoria_game/utils/secure_storage.dart';

import '../../../../global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import '../../../../routes/app_pages.dart';

class AuthSignInController extends GetxController {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late UserRepository userRepository;
  late SecureStorage secureStorage;

  bool validateSingIn() {
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
          description: "Tolong masukkan password kamu ya!",
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

  @override
  void onInit() {
    userRepository = UserRepository.instance;
    secureStorage = SecureStorage.instance;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  void signIn() async {
    if (validateSingIn()) {
      var userResponse = await userRepository.submitSignIn(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userResponse.message == "Email not registered") {
        Get.dialog(
          const SingleActionDialog(
            title: "Email Kamu Belum Terdaftar",
            description:
                "Kamu mungkin salah memasukkan Email, Coba cek lagi ya! Atau bisa daftar aja",
          ),
        );
      } else if (userResponse.message == "Wrong password") {
        Get.dialog(
          const SingleActionDialog(
            title: "Password Kamu Salah",
            description:
                "Kamu mungkin salah memasukkan Password, Coba cek lagi ya! Atau bisa daftar aja",
          ),
        );
      } else {
        var putToStorage = secureStorage.writeDataToStorage(
            key: "token", value: userResponse.data?.token ?? "");
        Get.offNamed(Routes.MAIN_PAGE_HOME);
      }
      var getFromStorage = await secureStorage.readDataFromStrorage("token");
      print("From API : ${userResponse.data?.token ?? ""}");
      print("From Storage : $getFromStorage");
    }
  }
}
