import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';

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
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
