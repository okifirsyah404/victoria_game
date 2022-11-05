import 'package:get/get.dart';

import '../controllers/main_page_ps_services_controller.dart';

class MainPagePsServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPagePsServicesController>(
      () => MainPagePsServicesController(),
    );
  }
}
