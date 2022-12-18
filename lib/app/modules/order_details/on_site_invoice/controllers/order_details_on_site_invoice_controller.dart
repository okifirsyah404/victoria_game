import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:victoria_game/app/core/repository/order_on_site_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class OrderDetailsOnSiteInvoiceController extends GetxController {
  final _arguments = Get.arguments;

  late SecureStorage _secureStorage;
  late OrderOnSiteRepository _orderOnSiteRepository;

  late ScreenshotController screenshotController;

  String get transactionId => _arguments["rentalId"];
  String get paymentMethod => _arguments["paymentMethod"];

  late String gameCenter;
  late int totalAmount;
  late String location;
  late String playstationNumber;
  late String playstationType;
  late int playtime;
  late String playingDate;
  late String playingTime;
  late String username;
  late String userMail;
  late String userPhone;

  Future<void> fetchTransactionData() async {
    String authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _orderOnSiteRepository.getDetailOrderOnSiteInvoice(
        authToken: authToken, transactionId: transactionId);

    username = result.data?.userName ?? "";
    userMail = result.data?.userEmail ?? "";
    userPhone = result.data?.userPhone ?? "";
    gameCenter = result.data?.gameCenterName ?? "";
    totalAmount = result.data?.totalAmount ?? 0;
    location = result.data?.gameCenterId ?? "";
    playstationNumber = result.data?.playstationId ?? "";
    playstationType = result.data?.playstationType ?? "";
    playtime = result.data?.playtime ?? 0;

    var localTimeZoneFormat = result.data?.startPlay?.toLocal();

    playingDate = DateFormat("dd MMMM yyyy", "id_ID")
        .format(localTimeZoneFormat ?? DateTime.now());

    playingTime =
        DateFormat("Hm", "id_ID").format(localTimeZoneFormat ?? DateTime.now());
  }

  Future<bool> requestCameraGaleryPermissions() async {
    var galeryPermission =
        await _orderOnSiteRepository.handleGaleryPermission();

    if (!galeryPermission) {
      Get.dialog(
        SingleActionDialog(
          title: "Akses Kamera Dan Galeri Ditolak",
          description:
              "Kami membutuhkan akses kamera serta galeri untuk mengupdate profile kamu.",
          buttonFunction: () async {
            await _orderOnSiteRepository.requestOpenAppSettings();
            Get.back();
          },
        ),
      );

      return false;
    }

    return galeryPermission;
  }

  Future<void> shareTransactionData() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/$transactionId.png').create();
        await imagePath.writeAsBytes(image);

        await Share.shareXFiles(
          [XFile(imagePath.path)],
          text:
              "Ayo kawan! Kita main bersama di $gameCenter. Sudah saya pesan ${playstationType.toTitleCase()} dengan No. $playstationNumber",
        );
      }
    });
  }

  Future<void> intentWhatsapp() async {
    String message = """
Saya ingin bertanya dengan transaksi ini.

INFORMASI PENGGUNA:

    Username : $username,
    Nomor Handphone: $userPhone,
    Alamat Email : $userMail,
    Tanggal : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())},
    Jam : ${DateFormat("Hm", "id_ID").format(DateTime.now().toLocal())}

INFORMASI TRANSAKSI

    Kode Transaksi : $transactionId,
    Total Biaya : ${totalAmount.toRupiah()}
    Game Center : $gameCenter,
    Jenis Playstation : $playstationType,
    Nomor Playstation : $playstationNumber,
    Tanggal Main : $playingDate,
    Jam Main : $playingTime,
    Playtime : $playtime,

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
    _orderOnSiteRepository = OrderOnSiteRepository.instance;
    screenshotController = ScreenshotController();
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
