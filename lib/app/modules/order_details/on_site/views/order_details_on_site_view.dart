import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_details_on_site_controller.dart';

class OrderDetailsOnSiteView extends GetView<OrderDetailsOnSiteController> {
  const OrderDetailsOnSiteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderDetailsOnSiteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderDetailsOnSiteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
