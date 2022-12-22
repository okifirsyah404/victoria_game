import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class MainPageHistoryController extends GetxController
    with GetTickerProviderStateMixin {
  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  late TabController mainTabController;
  late TabController playOnSiteTabController;

  late CountdownTimerController countdownTimerController;

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

  final List<Tab> secondaryTab = [
    const Tab(
      text: "Akan Datang",
    ),
    const Tab(
      text: "Selesai",
    ),
  ];

  RxBool isRentOnSiteActive = false.obs;

  Map<String, dynamic> currentOnSitePlaying = {
    "playstationType": "",
    "playtime": 0,
    "endTime": DateTime.now()
  };

  List<Map<String, dynamic>> previousPlayOnSiteHistoryList = [];
  List<Map<String, dynamic>> futurePlayOnSiteHistoryList = [];

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

      isRentOnSiteActive.value = true;
    }
  }

  Future<void> fetchPreviousOnSiteHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    await fetchCurrentOnSitePlaying();

    var result = await _historyRepository.getPreviousPlayOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        result.data!.forEach((element) {
          previousPlayOnSiteHistoryList.add({
            "rentalId": element.rentalId,
            "gameCenter": element.gameCenter,
            "totalAmount": element.totalAmount,
            "orderDate": element.orderTime,
            "playstationType": element.playstationType,
          });
        });
      }
    }
  }

  Future<void> fetchFutureOnSiteHistory() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    await fetchCurrentOnSitePlaying();

    var result = await _historyRepository.getFuturePlayOnSiteHistory(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        result.data!.forEach((element) {
          futurePlayOnSiteHistoryList.add({
            "rentalId": element.rentalId,
            "gameCenter": element.gameCenter,
            "totalAmount": element.totalAmount,
            "orderDate": element.orderTime,
            "playstationType": element.playstationType,
          });
        });
      }
    }
  }

  Future<void> fetchOrderOnSiteHistory() async {
    await fetchCurrentOnSitePlaying();
    await fetchFutureOnSiteHistory();
    await fetchPreviousOnSiteHistory();
  }

  void onTapPreviousOrderOnSiteHistoryItem(int index) {
    Get.toNamed(Routes.HISTORY_ORDER_ON_SITE_INVOICE, arguments: {
      "rentalId": previousPlayOnSiteHistoryList[index]["rentalId"]
    });
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
    mainTabController = TabController(length: mainTab.length, vsync: this);
    playOnSiteTabController =
        TabController(length: secondaryTab.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    mainTabController.dispose();
    countdownTimerController.dispose();
    super.onClose();
  }
}
