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

      Get.toNamed(Routes.ORDER_DETAILS_ON_SITE_INVOICE, arguments: {
        "rentalId": rentalData.data?.rentalId,
      });
    } else {
      Get.dialog(SingleActionDialog(
        title: result.message,
        description: "Result ${result.data.verified}, $_arguments",
      ));
    }
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _orderOnSiteRepository = OrderOnSiteRepository.instance;
    passwordController = TextEditingController();
    print(_arguments);
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
