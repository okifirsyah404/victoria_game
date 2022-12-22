import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class HistoryOrderOnSiteInvoiceController extends GetxController {
  final _arguments = Get.arguments;

  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  late CountdownTimerController countdownTimerController;

  String get rentalId => _arguments["rentalId"];

  late DetailTransactionDataHistory detailTransactionDataHistory;

  RxBool isCurrentPlaying = false.obs;
  String timeInterval = "";

  Future<void> fetchTransactionDetail() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _historyRepository.getDetailPlayOnSiteHistory(
        authToken: authToken, rentalId: rentalId);

    if (result.data?.rentalId != null) {
      var startTime =
          DateFormat("Hm", "id_ID").format(result.data!.startTime!.toLocal());
      var endTime =
          DateFormat("Hm", "id_ID").format(result.data!.endTime!.toLocal());

      timeInterval = "${startTime} - ${endTime}";

      countdownTimerController = CountdownTimerController(
        endTime:
            (result.data?.endTime ?? DateTime.now()).millisecondsSinceEpoch,
        onEnd: () {
          isCurrentPlaying.value = false;
        },
      );

      if (result.data!.startTime!.toLocal().isBefore(
                DateTime.now(),
              ) &&
          result.data!.endTime!.toLocal().isAfter(
                DateTime.now(),
              )) {
        isCurrentPlaying.value = true;
      }

      detailTransactionDataHistory = DetailTransactionDataHistory(
        rentalId: result.data!.rentalId!,
        orderTime: result.data!.orderTime!.toLocal(),
        gameCenter: result.data!.gameCenter!,
        gameCenterLocation: result.data!.gameCenterLocation!,
        startTime: result.data!.startTime!.toLocal(),
        endTime: result.data!.endTime!.toLocal(),
        totalAmount: result.data!.totalAmount!,
        paymentMethod: result.data!.paymentMethod!,
        playtime: result.data!.playtime!,
        playstationId: result.data!.playstationId!,
        playstationType: result.data!.playstationType!,
        userId: result.data!.userId!,
        email: result.data!.email!,
        username: result.data!.username!,
        phoneNumber: result.data!.phoneNumber!,
        timeInterval: timeInterval,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
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

class DetailTransactionDataHistory {
  DetailTransactionDataHistory({
    required this.rentalId,
    required this.orderTime,
    required this.gameCenter,
    required this.gameCenterLocation,
    required this.startTime,
    required this.endTime,
    required this.totalAmount,
    required this.paymentMethod,
    required this.playtime,
    required this.playstationId,
    required this.playstationType,
    required this.userId,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.timeInterval,
  });

  final String rentalId;
  final DateTime orderTime;
  final String gameCenter;
  final String gameCenterLocation;
  final DateTime startTime;
  final DateTime endTime;
  final int totalAmount;
  final String paymentMethod;
  final int playtime;
  final String playstationId;
  final String playstationType;
  final String userId;
  final String email;
  final String username;
  final String phoneNumber;
  final String timeInterval;
}
