import 'package:get/get.dart';

import '../controllers/order_details_on_site_verify_controller.dart';

class OrderDetailsOnSiteVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsOnSiteVerifyController>(
      () => OrderDetailsOnSiteVerifyController(),
    );
  }
}
