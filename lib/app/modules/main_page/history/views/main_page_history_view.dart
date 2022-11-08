import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import '../controllers/main_page_history_controller.dart';

class MainPageHistoryView extends GetView<MainPageHistoryController> {
  const MainPageHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPageHistoryView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MainPageHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
