import 'package:get/get.dart';

import '../controllers/main_page_rent_controller.dart';

class MainPageRentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageRentController>(
      () => MainPageRentController(),
    );
  }
}
