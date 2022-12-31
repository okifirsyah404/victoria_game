import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/playstation_service_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../../../global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';

class ServiceVerifyController extends GetxController {
  final _arguments = Get.arguments;

  String get problem => _arguments["problem"];
  String get detailProblem => _arguments["detailProblem"];
  String get productName => _arguments["productName"];

  late SecureStorage _secureStorage;
  late PlaystationServiceRepository _playstationServiceRepository;

  late TextEditingController passwordController;

  void submitVerifyOrder() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _playstationServiceRepository.verifyPlaystationService(
        password: passwordController.text.convertToSHA256(),
        authToken: authToken);

    if (result.data.verified) {
      var serviceData =
          await _playstationServiceRepository.postPlaystationServiceRequest(
        authToken: authToken,
        problem: problem,
        detailProblem: detailProblem,
        productName: productName,
      );

      Get.offAllNamed(Routes.SERVICE_INVOICE, arguments: {
        "serviceId": serviceData.data?.servisId,
      });
    } else {
      Get.dialog(const SingleActionDialog(
        title: "Password Salah",
        description:
            "Tolong masukan password yang benar agar kami yakin bahwa itu anda",
      ));
    }
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _playstationServiceRepository = PlaystationServiceRepository.instance;
    passwordController = TextEditingController();
    print(_arguments);
  }


  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
