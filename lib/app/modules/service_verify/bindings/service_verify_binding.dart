import 'package:get/get.dart';

import '../controllers/service_verify_controller.dart';

class ServiceVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceVerifyController>(
      () => ServiceVerifyController(),
    );
  }
}
