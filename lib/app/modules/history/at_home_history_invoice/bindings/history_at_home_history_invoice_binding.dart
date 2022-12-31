import 'package:get/get.dart';

import '../controllers/history_at_home_history_invoice_controller.dart';

class HistoryAtHomeHistoryInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryAtHomeHistoryInvoiceController>(
      () => HistoryAtHomeHistoryInvoiceController(),
    );
  }
}
