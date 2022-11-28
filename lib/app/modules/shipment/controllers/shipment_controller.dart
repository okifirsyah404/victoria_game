import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class ShipmentController extends GetxController {
  //TODO: Implement ShipmentController

  // var _arguments = Get.arguments;

  // Map<String, dynamic> get itemData => _arguments[0];
  // int get timeInterval => _arguments[1];

  RxBool isMethodEnable = false.obs;

  Map<String, dynamic> result = {};

  late final List<Map<String, dynamic>> _shipmentMethods = [
    {
      "methodTitle": "Shipment by Official",
      "description":
          "Jumlah durasi penyewaan playstation terpenuhi, dapat diantarkan dengan jarak max 10km",
      "isEnable": isMethodEnable.value
    },
    {
      "methodTitle": "Take Away",
      "description":
          "Kamu dapat mengambil playstation yang kamu sewa di lokasi Tolonto.",
      "isEnable": true
    },
  ];

  List<Map<String, dynamic>> get shipmentMethods => _shipmentMethods;

  void onTapShipmentMethod(int index) {
    if (index > 0) {
      Get.back(result: _shipmentMethods[index]);
    } else {
      Get.toNamed(Routes.MAPS);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // print(result);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
