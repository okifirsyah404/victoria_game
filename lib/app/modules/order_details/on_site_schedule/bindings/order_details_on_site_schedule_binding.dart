import 'package:get/get.dart';

import '../controllers/order_details_on_site_schedule_controller.dart';

class OrderDetailsOnSiteScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsOnSiteScheduleController>(
      () => OrderDetailsOnSiteScheduleController(),
    );
  }
}
