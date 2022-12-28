import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_details_at_home_playstation_list_controller.dart';

class OrderDetailsAtHomePlaystationListView
    extends GetView<OrderDetailsAtHomePlaystationListController> {
  const OrderDetailsAtHomePlaystationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderDetailsAtHomePlaystationListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderDetailsAtHomePlaystationListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
