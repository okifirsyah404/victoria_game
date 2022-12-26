import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/playstation_service_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ServiceController extends GetxController {
  //TODO: Implement ServiceController

  late SecureStorage _secureStorage;
  late UserRepository _userRepository;
  late PlaystationServiceRepository _playstationServiceRepository;

  late TextEditingController productController;
  late TextEditingController detailServiceController;

  late RxString dropDownInitialSelected;
  late String userId;
  late String authToken;

  List<String> listItem = [
    "Playstation Tidak Menyala",
    "Tidak Muncul Gambar (Blank)",
    "Kabel AV Tidak Terbaca",
    "Mati Total",
    "Hardisk Tidak Terbaca",
    "Sering Overheat",
    "Kontroler Tidak Terbaca",
    "Instalasi Harddisk",
    "Ganti atau Isi Game",
  ];

  void onChangeDropDown(String? newValue) {
    dropDownInitialSelected.value = newValue ?? "";
  }

  Future<void> fetchUserData() async {
    authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _userRepository.fetchUserData(authToken);

    userId = result.data?.userId ?? "";
  }

  void submitPlaystationServiceRequest() async {
    var result =
        await _playstationServiceRepository.postPlaystationServiceRequest(
            authToken: authToken,
            productName: productController.text,
            problem: dropDownInitialSelected.value,
            detailProblem: detailServiceController.text);
    Get.dialog(
      SingleActionDialog(
        title: "Done",
        description: result.data!.servisId!,
      ),
    );
  }

  @override
  void onInit() {
    _secureStorage = SecureStorage.instance;
    _userRepository = UserRepository.instance;
    _playstationServiceRepository = PlaystationServiceRepository.instance;
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
