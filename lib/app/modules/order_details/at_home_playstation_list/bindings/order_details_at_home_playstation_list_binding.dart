import 'package:get/get.dart';

import '../controllers/order_details_at_home_playstation_list_controller.dart';

class OrderDetailsAtHomePlaystationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsAtHomePlaystationListController>(
      () => OrderDetailsAtHomePlaystationListController(),
    );
  }
}
