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

class PendingPlaystationServiceHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<Map<String, dynamic>> pendingPlaystationServiceHistoryList =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchPendingPlaystationServiceHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getPendingPlaystationServiceHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        pendingPlaystationServiceHistoryList.clear();
        for (var element in result.data!) {
          pendingPlaystationServiceHistoryList.add({
            "serviceId": element.serviceId,
            "productName": element.productName,
            "submitTime": element.submitTime,
            "problem": element.problem,
            "gameCenter": element.gameCenter,
            "status": element.status,
          });
        }
      }
    }
  }

  void onTapPendingPlaystationHistoryHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_SERVICE_INVOICE, arguments: {
      "serviceId": pendingPlaystationServiceHistoryList[index]["serviceId"]
    });
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}

class ProgressPlaystationServiceHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<Map<String, dynamic>> progressPlaystationServiceHistoryList =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchProgressPlaystationServiceHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getProgressPlaystationServiceHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        progressPlaystationServiceHistoryList.clear();
        for (var element in result.data!) {
          progressPlaystationServiceHistoryList.add({
            "serviceId": element.serviceId,
            "productName": element.productName,
            "submitTime": element.submitTime,
            "problem": element.problem,
            "gameCenter": element.gameCenter,
            "status": element.status,
          });
        }
      }
    }
  }

  void onTapProgressPlaystationHistoryHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_SERVICE_INVOICE, arguments: {
      "serviceId": progressPlaystationServiceHistoryList[index]["serviceId"]
    });
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}

class FinishedPlaystationServiceHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<Map<String, dynamic>> finishedPlaystationServiceHistoryList =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchFinishedPlaystationServiceHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getFinishedPlaystationServiceHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        finishedPlaystationServiceHistoryList.clear();
        for (var element in result.data!) {
          finishedPlaystationServiceHistoryList.add({
            "serviceId": element.serviceId,
            "productName": element.productName,
            "submitTime": element.submitTime,
            "problem": element.problem,
            "gameCenter": element.gameCenter,
            "status": element.status,
          });
        }
      }
    }
  }

  void onTapFinishedPlaystationHistoryHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_SERVICE_INVOICE, arguments: {
      "serviceId": finishedPlaystationServiceHistoryList[index]["serviceId"]
    });
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}

class CanceledPlaystationServiceHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<Map<String, dynamic>> canceledPlaystationServiceHistoryList =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchCanceledPlaystationServiceHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getCanceledPlaystationServiceHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        canceledPlaystationServiceHistoryList.clear();
        for (var element in result.data!) {
          canceledPlaystationServiceHistoryList.add({
            "serviceId": element.serviceId,
            "productName": element.productName,
            "submitTime": element.submitTime,
            "problem": element.problem,
            "gameCenter": element.gameCenter,
            "status": element.status,
          });
        }
      }
    }
  }

  void onTapCanceledPlaystationHistoryHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_SERVICE_INVOICE, arguments: {
      "serviceId": canceledPlaystationServiceHistoryList[index]["serviceId"]
    });
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}
