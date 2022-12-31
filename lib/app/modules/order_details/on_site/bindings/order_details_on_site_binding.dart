import 'package:get/get.dart';

import '../controllers/order_details_on_site_controller.dart';

class OrderDetailsOnSiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsOnSiteController>(
      () => OrderDetailsOnSiteController(),
    );
  }
}
