import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import '../controllers/main_page_ps_services_controller.dart';

class MainPagePsServicesView extends GetView<MainPagePsServicesController> {
  const MainPagePsServicesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPagePsServicesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MainPagePsServicesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
