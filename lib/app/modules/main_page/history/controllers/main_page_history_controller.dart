import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class MainPageHistoryController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController mainTabController;

  final List<Tab> mainTab = [
    const Tab(
      text: "Play At Game Center",
    ),
    const Tab(
      text: "Play At Home",
    ),
    const Tab(
      text: "Servis Playstation",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    mainTabController = TabController(length: mainTab.length, vsync: this);
  }

  @override
  void onClose() {
    mainTabController.dispose();
    super.onClose();
  }
}
