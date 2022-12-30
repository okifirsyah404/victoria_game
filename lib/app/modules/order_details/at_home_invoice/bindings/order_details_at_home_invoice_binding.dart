import 'package:get/get.dart';

import '../controllers/order_details_at_home_invoice_controller.dart';

class OrderDetailsAtHomeInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsAtHomeInvoiceController>(
      () => OrderDetailsAtHomeInvoiceController(),
    );
  }
}
