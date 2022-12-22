import 'package:get/get.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/order_on_site_history_controller.dart';

import '../controllers/main_page_history_controller.dart';

class MainPageHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageHistoryController>(
      () => MainPageHistoryController(),
    );
    Get.lazyPut<OrderOnSiteHistoryController>(
      () => OrderOnSiteHistoryController(),
    );
    Get.lazyPut<PreviousOrderOnSiteHistoryController>(
      () => PreviousOrderOnSiteHistoryController(),
    );
    Get.lazyPut<FutureOrderOnSiteHistoryController>(
      () => FutureOrderOnSiteHistoryController(),
    );
  }
}
