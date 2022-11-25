import 'package:get/get.dart';

class ShipmentController extends GetxController {
  //TODO: Implement ShipmentController

  var argument = Get.arguments;

  List<Map<String, dynamic>> shipmentMethods = [
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

  List<Map<String, dynamic>> get getShipmentMethods => shipmentMethods;

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
