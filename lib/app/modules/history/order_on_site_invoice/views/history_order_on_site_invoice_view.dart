import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_order_on_site_invoice_controller.dart';

class HistoryOrderOnSiteInvoiceView
    extends GetView<HistoryOrderOnSiteInvoiceController> {
  const HistoryOrderOnSiteInvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryOrderOnSiteInvoiceView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HistoryOrderOnSiteInvoiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
