import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/playstation_service_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ServiceController extends GetxController {
  late SecureStorage _secureStorage;
  late UserRepository _userRepository;

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
    "Kerusakan Lain",
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
    if (productController.text.isNotEmpty &&
        detailServiceController.text.isNotEmpty) {
      Get.toNamed(
        Routes.SERVICE_VERIFY,
        arguments: {
          "productName": productController.text,
          "problem": dropDownInitialSelected.value,
          "detailProblem": detailServiceController.text,
        },
      );
    } else {
      Get.dialog(
        const SingleActionDialog(
          title: "Terdapat Form Yang Kosong",
          description:
              "Pastikan Nama Produk dan Detail Permasalahan kamu terisi ya!",
        ),
      );
    }
  }

  @override
  void onInit() {
    _secureStorage = SecureStorage.instance;
    _userRepository = UserRepository.instance;
    productController = TextEditingController();
    detailServiceController = TextEditingController();

    dropDownInitialSelected = listItem[0].obs;
    super.onInit();
  }

  @override
  void onClose() {
    productController.dispose();
    detailServiceController.dispose();
    super.onClose();
  }
}
