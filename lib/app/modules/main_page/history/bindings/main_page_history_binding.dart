import 'package:get/get.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/order_at_home_history_controller.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/order_on_site_history_controller.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/playstation_service_history_controller.dart';

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
    Get.lazyPut<PlaystationServiceHistoryController>(
      () => PlaystationServiceHistoryController(),
    );
    Get.lazyPut<PendingPlaystationServiceHistoryController>(
      () => PendingPlaystationServiceHistoryController(),
    );
    Get.lazyPut<ProgressPlaystationServiceHistoryController>(
      () => ProgressPlaystationServiceHistoryController(),
    );
    Get.lazyPut<FinishedPlaystationServiceHistoryController>(
      () => FinishedPlaystationServiceHistoryController(),
    );
    Get.lazyPut<CanceledPlaystationServiceHistoryController>(
      () => CanceledPlaystationServiceHistoryController(),
    );
    Get.lazyPut<OrderAtHomeHistoryController>(
      () => OrderAtHomeHistoryController(),
    );
    Get.lazyPut<PendingOrderAtHomeHistoryController>(
      () => PendingOrderAtHomeHistoryController(),
    );
    Get.lazyPut<ActiveOrderAtHomeHistoryController>(
      () => ActiveOrderAtHomeHistoryController(),
    );
    Get.lazyPut<FinishedOrderAtHomeHistoryController>(
      () => FinishedOrderAtHomeHistoryController(),
    );
    Get.lazyPut<CanceledOrderAtHomeHistoryController>(
      () => CanceledOrderAtHomeHistoryController(),
    );
  }
}
