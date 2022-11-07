import 'package:get/get.dart';

import '../controllers/main_page_history_controller.dart';

class MainPageHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageHistoryController>(
      () => MainPageHistoryController(),
    );
  }
}
