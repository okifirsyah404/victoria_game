import 'package:get/get.dart';

import '../controllers/order_details_at_home_verify_controller.dart';

class OrderDetailsAtHomeVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsAtHomeVerifyController>(
      () => OrderDetailsAtHomeVerifyController(),
    );
  }
}
