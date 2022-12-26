import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class PlaystationServiceHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  late TabController playstationServiceHistoryTabController;

  final List<Tab> secondaryTab = [
    const Tab(
      text: "Menunggu Konfirmasi",
    ),
    const Tab(
      text: "Diproses",
    ),
    const Tab(
      text: "Selesai",
    ),
    const Tab(
      text: "Dibatalkan",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
    playstationServiceHistoryTabController =
        TabController(length: secondaryTab.length, vsync: this);
  }

  @override
  void onClose() {
    playstationServiceHistoryTabController.dispose();
    super.onClose();
  }
}
