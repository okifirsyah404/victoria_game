import 'package:get/get.dart';

import '../controllers/history_service_invoice_controller.dart';

class HistoryServiceInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryServiceInvoiceController>(
      () => HistoryServiceInvoiceController(),
    );
  }
}
