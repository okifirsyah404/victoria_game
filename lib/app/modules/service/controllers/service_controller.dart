import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ServiceController extends GetxController {
  //TODO: Implement ServiceController

  late SecureStorage secureStorage;
  late UserRepository userRepository;

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController detailServiceController;

  late RxString dropDownInitialSelected;

  List<String> listItem = ["Playstation Tidak Menyala", "Instalasi Harddisk"];

  void onChangeDropDown(String? newValue) {
    dropDownInitialSelected.value = newValue ?? "";
  }

  Future<void> fetchUserData() async {
    var authToken = await secureStorage.readDataFromStrorage("token") ?? "";

    var result = await userRepository.fetchUserData(authToken);

    usernameController.text = result.data?.username ?? "";
    emailController.text = result.data?.email ?? "";
    phoneController.text = result.data?.phone ?? "";
  }

  @override
  void onInit() {
    secureStorage = SecureStorage.instance;
    userRepository = UserRepository.instance;
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    detailServiceController = TextEditingController();

    dropDownInitialSelected = listItem[0].obs;
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
