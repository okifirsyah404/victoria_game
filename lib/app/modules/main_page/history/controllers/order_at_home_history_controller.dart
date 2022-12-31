import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/network/response/history/summary_order_at_home_history_response.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class OrderAtHomeHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  late TabController playstationServiceHistoryTabController;

  final List<Tab> secondaryTab = [
    const Tab(
      text: "Menunggu Konfirmasi",
    ),
    const Tab(
      text: "Aktif",
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

class PendingOrderAtHomeHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<SummaryOrderAtHomeHistory> pendingOrderAtHomeHistoryList =
      <SummaryOrderAtHomeHistory>[].obs;

  Future<void> fetchPendingOrderAtHomeHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getPendingOrderOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        pendingOrderAtHomeHistoryList.clear();
        for (var element in result.data!) {
          pendingOrderAtHomeHistoryList.add(element);
        }
      }
    }
  }

  void onTapPendingOrderAtHomeHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_AT_HOME_HISTORY_INVOICE,
        arguments: {"rentalId": pendingOrderAtHomeHistoryList[index].orderId});
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}

class ActiveOrderAtHomeHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<SummaryOrderAtHomeHistory> activeOrderAtHomeHistoryList =
      <SummaryOrderAtHomeHistory>[].obs;

  Future<void> fetchActiveOrderAtHomeHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getActiveOrderOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        activeOrderAtHomeHistoryList.clear();
        for (var element in result.data!) {
          activeOrderAtHomeHistoryList.add(element);
        }
      }
    }
  }

  void onTapActiveOrderAtHomeHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_AT_HOME_HISTORY_INVOICE,
        arguments: {"rentalId": activeOrderAtHomeHistoryList[index].orderId});
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}

class FinishedOrderAtHomeHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<SummaryOrderAtHomeHistory> finishedOrderAtHomeHistoryList =
      <SummaryOrderAtHomeHistory>[].obs;

  Future<void> fetchFinishedOrderAtHomeHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getFinishedOrderOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        finishedOrderAtHomeHistoryList.clear();
        for (var element in result.data!) {
          finishedOrderAtHomeHistoryList.add(element);
        }
      }
    }
  }

  void onTapFinishedOrderAtHomeHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_AT_HOME_HISTORY_INVOICE,
        arguments: {"rentalId": finishedOrderAtHomeHistoryList[index].orderId});
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}

class CanceledOrderAtHomeHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<SummaryOrderAtHomeHistory> canceledOrderAtHomeHistoryList =
      <SummaryOrderAtHomeHistory>[].obs;

  Future<void> fetchCanceledOrderAtHomeHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getCanceledOrderOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        canceledOrderAtHomeHistoryList.clear();
        for (var element in result.data!) {
          canceledOrderAtHomeHistoryList.add(element);
        }
      }
    }
  }

  void onTapCanceledOrderAtHomeHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_AT_HOME_HISTORY_INVOICE,
        arguments: {"rentalId": canceledOrderAtHomeHistoryList[index].orderId});
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
  }
}
