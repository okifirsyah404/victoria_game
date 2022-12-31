import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:victoria_game/app/core/network/response/service/service_detail_response.dart';
import 'package:victoria_game/app/core/repository/history_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class HistoryServiceInvoiceController extends GetxController {
  final _arguments = Get.arguments;

  String get serviceId => _arguments["serviceId"];

  late SecureStorage _secureStorage;
  late HistoryRepository _historyRepository;
  late ScreenshotController screenshotController;
  late PlaystationServiceDetailData serviceData;

  String _statusConverter(String status) {
    if (status == "pending") return "Menunggu Konfirmasi";
    if (status == "progress") return "Diproses";
    if (status == "selesai") return "Selesai";
    if (status == "batal") return "Dibatalkan";
    return "";
  }

  Future<void> fetchTransactionDetail() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _historyRepository.getPlaystationServiceHistoryDetail(
        authToken: authToken, serviceId: serviceId);

    if (result.data != null) {
      var newStatus = _statusConverter(result.data!.status!);

      serviceData = PlaystationServiceDetailData(
        serviceId: result.data!.serviceId,
        detailProblem: result.data!.detailProblem,
        email: result.data!.email,
        finishTime: result.data!.finishTime,
        gameCenter: result.data!.gameCenter,
        location: result.data!.location,
        phoneNumber: result.data!.phoneNumber,
        problem: result.data!.problem,
        status: newStatus,
        productName: result.data!.productName,
        submitTime: result.data!.submitTime,
        userId: result.data!.userId,
        username: result.data!.username,
      );
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
              "Hi kawan! Setelah ${serviceData.productName} selesai diperbaiki, kita main bersama. Saat ini sedang diperbaiki di ${serviceData.gameCenter} dengan status ${serviceData.status}",
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

    Username : ${serviceData.username}
    Nomor Handphone: ${serviceData.phoneNumber}
    Alamat Email : ${serviceData.email}

INFORMASI TRANSAKSI

    Kode Transaksi : $serviceId
    Produk Servis : ${serviceData.productName}
    Permasalahan : ${serviceData.problem}
    Detail Permasalahan : ${serviceData.detailProblem}
    Tanggal Transaksi : ${serviceData.submitTime}
    Game Center : ${serviceData.gameCenter}
    Lokasi Game Center : ${serviceData.location}
    Status : ${serviceData.status}

DESKRIPSI

""";
    String url = "whatsapp://send?phone=+6285158304448&text=$message";

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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
