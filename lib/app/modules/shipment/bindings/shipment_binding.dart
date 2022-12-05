import 'package:get/get.dart';

import '../controllers/shipment_controller.dart';

class ShipmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShipmentController>(
      () => ShipmentController(),
    );
  }
}
