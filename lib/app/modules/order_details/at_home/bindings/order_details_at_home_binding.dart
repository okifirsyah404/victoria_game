import 'package:get/get.dart';

import '../controllers/order_details_at_home_controller.dart';

class OrderDetailsAtHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsAtHomeController>(
      () => OrderDetailsAtHomeController(),
    );
  }
}
