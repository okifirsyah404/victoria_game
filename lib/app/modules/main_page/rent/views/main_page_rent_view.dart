import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_page_rent_controller.dart';

class MainPageRentView extends GetView<MainPageRentController> {
  const MainPageRentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPageRentView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MainPageRentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
