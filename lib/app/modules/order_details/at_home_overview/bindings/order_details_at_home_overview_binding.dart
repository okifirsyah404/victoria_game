import 'package:get/get.dart';

import '../controllers/order_details_at_home_overview_controller.dart';

class OrderDetailsAtHomeOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsAtHomeOverviewController>(
      () => OrderDetailsAtHomeOverviewController(),
    );
  }
}
