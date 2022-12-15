import 'package:get/get.dart';

import '../controllers/history_order_on_site_invoice_controller.dart';

class HistoryOrderOnSiteInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryOrderOnSiteInvoiceController>(
      () => HistoryOrderOnSiteInvoiceController(),
    );
  }
}
