import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/order_on_site_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class OrderDetailsOnSiteVerifyController extends GetxController {
  final _arguments = Get.arguments;

  late SecureStorage _secureStorage;
  late OrderOnSiteRepository _orderOnSiteRepository;

  late TextEditingController passwordController;

  void submitVerifyOrder() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _orderOnSiteRepository.verifyOrderOnSite(
        password: passwordController.text.convertToSHA256(),
        authToken: authToken);

    if (result.data.verified) {
      var rentalData = await _orderOnSiteRepository.postOrderOnSiteData(
          authToken: authToken, body: _arguments);

      Get.offAllNamed(Routes.ORDER_DETAILS_ON_SITE_INVOICE, arguments: {
        "rentalId": rentalData.data?.rentalId,
        "paymentMethod": _arguments["paymentMethod"],
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
    _orderOnSiteRepository = OrderOnSiteRepository.instance;
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
