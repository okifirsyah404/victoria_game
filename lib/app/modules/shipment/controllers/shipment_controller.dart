import 'dart:async';

import 'package:get/get.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_available_playstation_response.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class ShipmentController extends GetxController {
  final _arguments = Get.arguments;

  String get playstationType => _arguments["playstationType"];
  DateTime get startDate => _arguments["date"]["start"];
  DateTime get finishDate => _arguments["date"]["finish"];
  Map<String, dynamic> get payment => _arguments["payment"];
  int get totalAmount => _arguments["totalAmount"];
  int get playtime => _arguments["playtime"];
  OrderAtHomeAvailablePlaystation get playstationData =>
      _arguments["playstationData"];

  final List<Map<String, dynamic>> shipmentMethods = [
    {
      "methodTitle": "Shipment by Official",
      "description":
          "Jumlah durasi penyewaan belum terpenuhi, silahkan pilih metode pengiriman lain.",
      "enabled": false,
    },
    {
      "methodTitle": "Take Away",
      "description":
          "Kamu dapat mengambil playstation yang kamu sewa di lokasi Tolonto.",
      "enabled": true,
    },
  ];

  Future<void> checkShipmentMethod() async {
    if (playtime >= 3) {
      shipmentMethods[0]["description"] =
          "Jumlah durasi penyewaan playstation terpenuhi, dapat diantarkan dengan jarak max 10km";
      shipmentMethods[0]["enabled"] = true;
    }
  }

  void onTapShipmentMethod(int index) {
    if (index > 0) {
      Get.toNamed(
        Routes.ORDER_DETAILS_AT_HOME_OVERVIEW,
        arguments: {
          "playstationType": playstationType,
          "date": {
            "start": startDate,
            "finish": finishDate,
          },
          "payment": payment,
          "totalAmount": totalAmount,
          "playtime": playtime,
          "playstationData": playstationData,
          "shipment": {
            "method": shipmentMethods[index]["methodTitle"],
            "description": shipmentMethods[index]["description"],
          },
        },
      );
    } else {
      Get.toNamed(
        Routes.MAPS,
        arguments: {
          "playstationType": playstationType,
          "date": {
            "start": startDate,
            "finish": finishDate,
          },
          "payment": payment,
          "totalAmount": totalAmount,
          "playtime": playtime,
          "playstationData": playstationData,
          "shipment": {
            "method": shipmentMethods[index]["methodTitle"],
            "description": shipmentMethods[index]["description"],
          },
        },
      );
    }
  }

  @override
  void onInit() {
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
