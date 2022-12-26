import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class HistoryOrderOnSiteInvoiceController extends GetxController {
  final _arguments = Get.arguments;

  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;

  late ScreenshotController screenshotController;
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

      timeInterval = "$startTime - $endTime";

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

  void shareTransactionData() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File(
                '${directory.path}/${detailTransactionDataHistory.rentalId}.png')
            .create();
        await imagePath.writeAsBytes(image);

        await Share.shareXFiles(
          [XFile(imagePath.path)],
          text:
              "Ayo kawan! Kita main bersama di ${detailTransactionDataHistory.gameCenter}. Sudah saya pesan ${detailTransactionDataHistory.playstationType.toTitleCase()} dengan No. ${int.parse(detailTransactionDataHistory.playstationId.substring(4))}",
        );
      }
    });
  }

  void saveScreenshotGalery() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        await ImageGallerySaver.saveImage(image,
            quality: 60, name: detailTransactionDataHistory.rentalId);
      }
    });

    Get.dialog(const SingleActionDialog(
      title: "Screenshot Berhasil",
      description: "Screenshot transaksi ini berhasil disimpan di galery",
    ));
  }

  void intentWhatsapp() async {
    String message = """
Saya ingin bertanya dengan transaksi ini.

INFORMASI PENGGUNA:

    Username : ${detailTransactionDataHistory.username}
    Nomor Handphone: ${detailTransactionDataHistory.phoneNumber}
    Alamat Email : ${detailTransactionDataHistory.email}
    Tanggal : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())}
    Jam : ${DateFormat("Hm", "id_ID").format(DateTime.now().toLocal())}

INFORMASI TRANSAKSI

    Kode Transaksi : ${detailTransactionDataHistory.rentalId}
    Tanggal Transaksi : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(detailTransactionDataHistory.orderTime)}
    Total Biaya : ${detailTransactionDataHistory.totalAmount.toRupiah()}
    Game Center : ${detailTransactionDataHistory.gameCenter}
    Jenis Playstation : ${detailTransactionDataHistory.playstationType.toTitleCase()}
    Nomor Playstation : ${detailTransactionDataHistory.playstationId}
    Tanggal Main : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(detailTransactionDataHistory.startTime)}
    Jam Main : ${DateFormat("Hm", "id_ID").format(detailTransactionDataHistory.startTime)}
    Playtime : ${detailTransactionDataHistory.playtime} Jam

DESKRIPSI

""";

    String url = "whatsapp://send?phone=+6282143212404&text=$message";

    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      Get.dialog(SingleActionDialog(
        title: "Error",
        description: e.toString(),
      ));
    }
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _historyRepository = HistoryRepository.instance;
    screenshotController = ScreenshotController();
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
