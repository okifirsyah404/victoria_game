import 'package:get/get.dart';

import '../controllers/maps_controller.dart';

class MapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(
      () => MapsController(),
    );
  }
}
