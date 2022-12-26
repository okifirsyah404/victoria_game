import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:victoria_game/app/core/repository/playstation_service_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/modules/main_page/controllers/main_page_index_controller.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ServiceInvoiceController extends GetxController {
  final _arguments = Get.arguments;

  String get serviceId => _arguments["serviceId"];

  late ScreenshotController screenshotController;
  late SecureStorage _secureStorage;
  late PlaystationServiceRepository _playstationServiceRepository;
  late MainPageIndexController _mainPageIndexController;

  late String productName;
  late String problem;
  late String detailProblem;
  late DateTime submitTime;
  late String status;
  late DateTime? finishTime;
  late String gameCenter;
  late String gameCenterLocation;
  late String userId;
  late String username;
  late String email;
  late String phoneNumber;

  Future<void> fetchTransactionData() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result =
        await _playstationServiceRepository.getPlaystationServiceRequestData(
            authToken: authToken, serviceId: serviceId);

    if (result.data?.serviceId != null) {
      productName = result.data!.productName!;
      problem = result.data!.problem!;
      detailProblem = result.data!.detailProblem!;
      submitTime = result.data!.submitTime!.toLocal();
      status = result.data!.status!;
      gameCenter = result.data!.gameCenter!;
      gameCenterLocation = result.data!.location!;
      userId = result.data!.userId!;
      username = result.data!.username!;
      email = result.data!.email!;
      phoneNumber = result.data!.phoneNumber!;
      finishTime = result.data!.finishTime;
    }
  }

  void shareTransactionData() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/$serviceId.png').create();
        await imagePath.writeAsBytes(image);

        await Share.shareXFiles(
          [XFile(imagePath.path)],
          text:
              "Hi kawan! Setelah $productName selesai diperbaiki, kita main bersama. Saat ini sedang diperbaiki di $gameCenter dengan status $status",
        );
      }
    });
  }

  void saveScreenshotGalery() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        await ImageGallerySaver.saveImage(image, quality: 60, name: serviceId);
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

    Username : $username
    Nomor Handphone: $phoneNumber
    Alamat Email : $email

INFORMASI TRANSAKSI

    Kode Transaksi : $serviceId
    Produk Servis : $productName
    Permasalahan : $problem
    Detail Permasalahan : $detailProblem
    Tanggal Transaksi : $submitTime
    Game Center : $gameCenter
    Lokasi Game Center : $gameCenterLocation
    Status : $status

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

  void onBackToHome() {
    Get.offNamedUntil(Routes.MAIN_PAGE_HOME, (route) => route.isFirst);
    _mainPageIndexController.changeIndex(0);
  }

  @override
  void onInit() {
    super.onInit();
    _mainPageIndexController = Get.find<MainPageIndexController>();
    _secureStorage = SecureStorage.instance;
    _playstationServiceRepository = PlaystationServiceRepository.instance;
    screenshotController = ScreenshotController();
  }
}
