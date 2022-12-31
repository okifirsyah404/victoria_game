import 'package:get/get.dart';

import '../controllers/order_details_on_site_invoice_controller.dart';

class OrderDetailsOnSiteInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsOnSiteInvoiceController>(
      () => OrderDetailsOnSiteInvoiceController(),
    );
  }
}
