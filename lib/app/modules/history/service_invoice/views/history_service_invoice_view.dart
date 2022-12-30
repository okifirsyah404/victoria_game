import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:screenshot/screenshot.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/list_tile/divider_list_tile.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../controllers/history_service_invoice_controller.dart';

class HistoryServiceInvoiceView
    extends GetView<HistoryServiceInvoiceController> {
  const HistoryServiceInvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Servis'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchTransactionDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return onDataDone();
          }
          return onDataLoading();
        },
      ),
    );
  }

  Widget onDataLoading() {
    return const Center(
      child: RiveAnimation.asset('assets/rive/loading.riv'),
    );
  }

  Widget onDataDone() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _screenshotBuilder(),
          const SizedBox(height: 8),
          _actionButtons(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _screenshotBuilder() {
    return Screenshot(
      controller: controller.screenshotController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardBuilder(),
            const SizedBox(height: 16),
            Text(
              "Data Servis",
              style: TypographyTheme.titleSmall.copyWith(
                color: ColorsTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            DividerListTile(
              title: "ID Servis",
              trailing: Text(controller.serviceId),
              topBorder: true,
            ),
            DividerListTile(
              title: "Game Center",
              trailing: Container(
                alignment: Alignment.centerRight,
                width: 180,
                child: Text(
                  controller.serviceData.gameCenter!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Lokasi Game Center",
              trailing: Text(controller.serviceData.location!),
              topBorder: true,
            ),
            DividerListTile(
              title: "Produk Servis",
              trailing: Container(
                alignment: Alignment.centerRight,
                width: 180,
                child: Text(
                  controller.serviceData.productName!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              topBorder: true,
              bottomBorder: true,
            ),
            DividerListTile(
              title: "Status Servis",
              trailing: Text(controller.serviceData.status!.toTitleCase()),
              topBorder: true,
            ),
            DividerListTile(
              title: "Permasalahan",
              trailing: Container(
                alignment: Alignment.centerRight,
                width: 180,
                child: Text(
                  controller.serviceData.problem!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              topBorder: true,
              bottomBorder: true,
            ),
            const SizedBox(height: 32),
            Text(
              "Detail Permasalahan",
              style: TypographyTheme.titleSmall.copyWith(
                color: ColorsTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                controller.serviceData.detailProblem!.isNotEmpty
                    ? controller.serviceData.detailProblem!
                    : "Tidak ada detail Permasalahan",
                style: TypographyTheme.bodyRegular,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Detail Waktu Servis",
              style: TypographyTheme.titleSmall.copyWith(
                color: ColorsTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            DividerListTile(
              title: "Tanggal Transaksi",
              trailing: Text(
                DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                    .format(controller.serviceData.submitTime!.toLocal()),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Waktu Transaksi",
              trailing: Text(
                DateFormat("Hm", "id_ID")
                    .format(controller.serviceData.submitTime!.toLocal()),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Tanggal Selesai",
              trailing: Text(
                controller.serviceData.finishTime != null
                    ? DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                        .format(controller.serviceData.finishTime!.toLocal())
                    : controller.serviceData.status! == "Dibatalkan"
                        ? "Dibatalkan"
                        : "Menunggu Konfirmasi",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Waktu Selesai",
              trailing: Text(
                controller.serviceData.finishTime != null
                    ? DateFormat("Hm", "id_ID")
                        .format(controller.serviceData.finishTime!.toLocal())
                    : controller.serviceData.status! == "Dibatalkan"
                        ? "Dibatalkan"
                        : "Menunggu Konfirmasi",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              topBorder: true,
              bottomBorder: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardBuilder() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorsTheme.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.serviceData.productName!.toTitleCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TypographyTheme.bodyMedium.copyWith(
                color: ColorsTheme.neutralColor[900],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: ColorsTheme.neutralColor[800],
              height: 8,
            ),
            const SizedBox(height: 8),
            Text(
              controller.serviceData.gameCenter!,
              style: TypographyTheme.bodyRegular.copyWith(
                color: ColorsTheme.neutralColor[900],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("dd MMMM yyyy", "id_ID")
                      .format(controller.serviceData.submitTime!.toLocal()),
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  controller.serviceData.status!,
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            controller.intentWhatsapp();
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF25D366),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: ColorsTheme.neutralColor[50],
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: () {
            controller.saveScreenshotGalery();
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsTheme.neutralColor[900],
            ),
            child: Center(
              child: Icon(
                Icons.copy,
                color: ColorsTheme.neutralColor[50],
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: () {
            controller.shareTransactionData();
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsTheme.neutralColor[900],
            ),
            child: Center(
              child: Icon(
                Icons.share,
                color: ColorsTheme.neutralColor[50],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
