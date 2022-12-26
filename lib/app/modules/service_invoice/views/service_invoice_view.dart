import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_invoice_controller.dart';

class ServiceInvoiceView extends GetView<ServiceInvoiceController> {
  const ServiceInvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceInvoiceView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ServiceInvoiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
