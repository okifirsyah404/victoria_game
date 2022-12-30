import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_detail_response.dart';
import 'package:victoria_game/app/core/repository/order_at_home_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/modules/main_page/controllers/main_page_index_controller.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class OrderDetailsAtHomeInvoiceController extends GetxController {
  final _arguments = Get.arguments;

  String get rentalId => _arguments["rentalId"];

  late SecureStorage _secureStorage;
  late OrderAtHomeRepository _orderAtHomeRepository;
  late MainPageIndexController _mainPageIndexController;
  late ScreenshotController screenshotController;

  late OrderAtHomeDetail orderAtHomeDetail;

  late String status;
  late String shipmentMethod;

  String _statusConverter(String status) {
    if (status == "pending") return "Menunggu Konfirmasi";
    if (status == "aktif") return "Dimainkan";
    if (status == "selesai") return "Selesai";
    if (status == "batal") return "Dibatalkan";
    return "";
  }

  String _shipmentConverter(String shipment) {
    if (shipment == "ambil") return "Take Away";
    if (shipment == "delivery") return "Shipment By Official";
    return "";
  }

  Future<void> fetchTransactionData() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _orderAtHomeRepository.getOrderAtHomeDetail(
        authToken: authToken, transactionId: rentalId);

    if (result.data != null) {
      if (result.data!.rentalId != null) {
        orderAtHomeDetail = result.data!;
        status = _statusConverter(result.data!.status!);
        shipmentMethod = _shipmentConverter(result.data!.shipmentMethod!);
      }
    }
  }

  void shareTransactionData() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/${orderAtHomeDetail.rentalId}.png')
                .create();
        await imagePath.writeAsBytes(image);

        await Share.shareXFiles(
          [XFile(imagePath.path)],
          text:
              "Hi kawan! Mari kita main ${orderAtHomeDetail.playstationType?.toTitleCase()} yang saya sewa. Kita dapat bermain mulai ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(orderAtHomeDetail.startTime!.toLocal())}",
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
            quality: 60, name: orderAtHomeDetail.rentalId);
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

    Username : ${orderAtHomeDetail.username}
    Nomor Handphone: ${orderAtHomeDetail.phoneNumber}
    Alamat Email : ${orderAtHomeDetail.email}

INFORMASI TRANSAKSI

    Kode Transaksi : ${orderAtHomeDetail.rentalId}
    Playstation : ${orderAtHomeDetail.playstationType?.toTitleCase()}
    Tanggal Transaksi : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(orderAtHomeDetail.orderTime!.toLocal())}
    Jam Transaksi : ${DateFormat("Hm", "id_ID").format(orderAtHomeDetail.orderTime!.toLocal())}
    Tanggal Mulai : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(orderAtHomeDetail.startTime!.toLocal())}
    Tanggal Selesai : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(orderAtHomeDetail.endTime!.toLocal())}
    Playtime : ${orderAtHomeDetail.playtime} Hari
    Total : ${orderAtHomeDetail.totalAmount!.toRupiah()}
    Metode Pembayaran : ${orderAtHomeDetail.paymentMethod!.toTitleCase()}
    Metode Pengiriman : $shipmentMethod
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
    Get.offAllNamed(Routes.MAIN_PAGE_HOME);
    _mainPageIndexController.changeIndex(0);
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _orderAtHomeRepository = OrderAtHomeRepository.instance;
    _mainPageIndexController = Get.find<MainPageIndexController>();
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
