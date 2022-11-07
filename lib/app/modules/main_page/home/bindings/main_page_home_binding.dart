import 'package:get/get.dart';

import '../controllers/main_page_home_controller.dart';

class MainPageHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageHomeController>(
      () => MainPageHomeController(),
    );
  }
}
