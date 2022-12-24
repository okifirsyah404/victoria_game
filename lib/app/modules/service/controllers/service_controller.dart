import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ServiceController extends GetxController {
  //TODO: Implement ServiceController

  late SecureStorage secureStorage;
  late UserRepository userRepository;

  late TextEditingController productController;
  late TextEditingController detailServiceController;

  late RxString dropDownInitialSelected;
  late String userId;

  List<String> listItem = ["Playstation Tidak Menyala", "Instalasi Harddisk"];

  void onChangeDropDown(String? newValue) {
    dropDownInitialSelected.value = newValue ?? "";
  }

  Future<void> fetchUserData() async {
    var authToken = await secureStorage.readDataFromStrorage("token") ?? "";

    var result = await userRepository.fetchUserData(authToken);

    userId = result.data?.userId ?? "";
  }

  @override
  void onInit() {
    secureStorage = SecureStorage.instance;
    userRepository = UserRepository.instance;
    productController = TextEditingController();
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
