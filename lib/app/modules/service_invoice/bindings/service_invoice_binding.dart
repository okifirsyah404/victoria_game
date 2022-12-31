import 'package:get/get.dart';

import '../controllers/service_invoice_controller.dart';

class ServiceInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceInvoiceController>(
      () => ServiceInvoiceController(),
    );
  }
}
