import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class ShipmentController extends GetxController {
  //TODO: Implement ShipmentController

  var _arguments = Get.arguments;

  final List<Map<String, dynamic>> _shipmentMethods = [
    {
      "methodTitle": "Shipment by Official",
      "description":
          "Jumlah durasi penyewaan playstation terpenuhi, dapat diantarkan dengan jarak max 10km",
    },
    {
      "methodTitle": "Take Away",
      "description":
          "Kamu dapat mengambil playstation yang kamu sewa di lokasi Tolonto.",
    },
  ];

  List<Map<String, dynamic>> get shipmentMethods => _shipmentMethods;

  void onTapShipmentMethod(int index) {
    if (index > 0) {
      Get.toNamed(
        Routes.ORDER_DETAILS_AT_HOME_OVERVIEW,
        arguments: [
          // arguments[0],
          // arguments[1],
          // arguments[2],
          // arguments[3],
          // shipmentMethods[index],
        ],
      );
    } else {
      Get.toNamed(
        Routes.MAPS,
        arguments: [
          // arguments[0],
          // arguments[1],
          // arguments[2],
          // arguments[3],
          // shipmentMethods[index],
        ],
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
