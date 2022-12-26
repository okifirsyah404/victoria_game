import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ProfileSettingsChangePhoneNumberController extends GetxController {
  late SecureStorage secureStorage;
  late UserRepository userRepository;

  late TextEditingController phoneController;

  late String initialPhoneNumber;

  Future<void> fetchUserPhoneNumber() async {
    var authToken = await secureStorage.readDataFromStrorage("token") ?? "";

    var result = await userRepository.fetchUserData(authToken);

    initialPhoneNumber = result.data?.phone ?? "";
    phoneController.text = initialPhoneNumber;
  }

  void onSubmitChangeNumber() async {
    var authToken = await secureStorage.readDataFromStrorage("token") ?? "";
    await userRepository.updatePhoneNumber(
        authToken: authToken, newPhoneNumber: phoneController.text);

    Get.offNamedUntil(
        Routes.PROFILE_SETTINGS_USER_PROFILE, (route) => route.isFirst);
  }

  @override
  void onInit() {
    secureStorage = SecureStorage.instance;
    userRepository = UserRepository.instance;
    phoneController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
