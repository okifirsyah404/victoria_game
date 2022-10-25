import 'package:get/get.dart';

import '../controllers/test_widget_controller.dart';

class TestWidgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestWidgetController>(
      () => TestWidgetController(),
    );
  }
}
