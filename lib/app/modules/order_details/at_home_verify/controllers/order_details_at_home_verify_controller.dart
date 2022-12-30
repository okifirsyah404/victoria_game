import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/order_at_home_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class OrderDetailsAtHomeVerifyController extends GetxController {
  final _arguments = Get.arguments;

  String get playstationType => _arguments["playstationType"];
  DateTime get startDate => _arguments["date"]["start"];
  DateTime get finishDate => _arguments["date"]["finish"];
  Map<String, dynamic> get payment => _arguments["payment"];
  int get totalAmount => _arguments["totalAmount"];
  int get playtime => _arguments["playtime"];
  String get playstationId => _arguments["playstationData"].playstationId;
  Map<String, dynamic> get shipment => _arguments["shipment"];
  String get notes => _arguments["notes"];

  late SecureStorage _secureStorage;
  late OrderAtHomeRepository _orderAtHomeRepository;

  late TextEditingController passwordController;

  void submitVerifyOrder() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _orderAtHomeRepository.verifyOrderOnSite(
        password: passwordController.text.convertToSHA256(),
        authToken: authToken);

    print({
      "playstationId": playstationId,
      "totalAmount": totalAmount,
      "playtime": playtime,
      "startDate": startDate.toLocal().toIso8601String(),
      "endDate": finishDate.toLocal().toIso8601String(),
      "shipmentMethod": shipment["method"],
      "latitude": shipment["latitude"] ?? 0,
      "longitude": shipment["longitude"] ?? 0,
      "description": notes,
      "paymentMethod": payment["paymentMethod"],
      "address": shipment["address"] ?? "",
    });

    if (result.data.verified) {
      var rentalData = await _orderAtHomeRepository.postOrderAtHomeData(
        authToken: authToken,
        body: {
          "playstationId": playstationId,
          "totalAmount": totalAmount,
          "playtime": playtime,
          "startDate": startDate.toLocal().toIso8601String(),
          "endDate": finishDate.toLocal().toIso8601String(),
          "shipmentMethod": shipment["method"],
          "latitude": shipment["latitude"] ?? 0,
          "longitude": shipment["longitude"] ?? 0,
          "description": notes,
          "paymentMethod": payment["paymentMethod"],
          "address": shipment["address"] ?? "",
        },
      );

      if (rentalData.data != null) {
        if (rentalData.data!.rentalId != null) {
          Get.offAllNamed(Routes.ORDER_DETAILS_AT_HOME_INVOICE, arguments: {
            "rentalId": rentalData.data?.rentalId,
          });
        }
      }
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
    _orderAtHomeRepository = OrderAtHomeRepository.instance;
    passwordController = TextEditingController();
    print(_arguments);
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
