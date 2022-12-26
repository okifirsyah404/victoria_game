import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class OrderOnSiteHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  late TabController playOnSiteTabController;
  late CountdownTimerController countdownTimerController;

  final List<Tab> secondaryTab = [
    const Tab(
      text: "Selesai",
    ),
    const Tab(
      text: "Akan Datang",
    ),
  ];

  String rentalId = "";
  RxBool isRentOnSiteActive = false.obs;

  Map<String, dynamic> currentOnSitePlaying = {
    "playstationType": "",
    "playtime": 0,
    "endTime": DateTime.now()
  };

  void onCountdownDone() {
    isRentOnSiteActive.value = false;
  }

  Future<void> fetchCurrentOnSitePlaying() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result =
        await _historyRepository.getCurrentPlayingOnSite(authToken: authToken);

    countdownTimerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch,
    );

    if (result.data?.playstationId != null) {
      currentOnSitePlaying["playstationType"] = result.data?.playstationType;
      currentOnSitePlaying["playtime"] = result.data?.playtime;

      countdownTimerController = CountdownTimerController(
        endTime:
            (result.data?.endTime ?? DateTime.now()).millisecondsSinceEpoch,
      );

      rentalId = result.data!.rentalId!;

      isRentOnSiteActive.value = true;
    }
  }

  void onTapItem() {
    Get.toNamed(Routes.HISTORY_ORDER_ON_SITE_INVOICE,
        arguments: {"rentalId": rentalId});
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
    playOnSiteTabController =
        TabController(length: secondaryTab.length, vsync: this);
  }

  @override
  void onClose() {
    countdownTimerController.dispose();
    playOnSiteTabController.dispose();
    super.onClose();
  }
}

class PreviousOrderOnSiteHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<Map<String, dynamic>> previousPlayOnSiteHistoryList =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchPreviousOnSiteHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getPreviousPlayOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        previousPlayOnSiteHistoryList.clear();
        for (var element in result.data!) {
          previousPlayOnSiteHistoryList.add({
            "rentalId": element.rentalId,
            "gameCenter": element.gameCenter,
            "totalAmount": element.totalAmount,
            "orderDate": element.orderTime,
            "playstationType": element.playstationType,
          });
        }
      }
    }
  }

  void onTapPreviousOrderOnSiteHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_ORDER_ON_SITE_INVOICE, arguments: {
      "rentalId": previousPlayOnSiteHistoryList[index]["rentalId"]
    });
  }

  @override
  void onInit() {
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
    super.onInit();
  }
}

class FutureOrderOnSiteHistoryController extends GetxController {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  RxList<Map<String, dynamic>> futurePlayOnSiteHistoryList =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchFutureOnSiteHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getFuturePlayOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        futurePlayOnSiteHistoryList.clear();
        for (var element in result.data!) {
          futurePlayOnSiteHistoryList.add({
            "rentalId": element.rentalId,
            "gameCenter": element.gameCenter,
            "totalAmount": element.totalAmount,
            "orderDate": element.orderTime,
            "playstationType": element.playstationType,
          });
        }
      }
    }
  }

  void onTapPreviousOrderOnSiteHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_ORDER_ON_SITE_INVOICE, arguments: {
      "rentalId": futurePlayOnSiteHistoryList[index]["rentalId"]
    });
  }

  @override
  void onInit() {
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
    super.onInit();
  }
}
