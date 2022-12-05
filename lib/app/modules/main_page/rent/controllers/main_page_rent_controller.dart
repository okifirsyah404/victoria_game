import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../../../../global/themes/colors_theme.dart';
import '../../../../global/themes/typography_theme.dart';

class MainPageRentController extends GetxController {
  final List<Map<String, dynamic>> _playstationList = [
    {
      "playstation": "Playstation 3",
      "price": 100000,
      "stock": 15,
    },
    {
      "playstation": "Playstation 4",
      "price": 120000,
      "stock": 10,
    },
  ];

  List<Map<String, dynamic>> get playstationList => _playstationList;

  void onItemTap(int index) {
    Get.toNamed(Routes.ORDER_DETAILS_AT_HOME,
        arguments: [_playstationList[index]]);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
