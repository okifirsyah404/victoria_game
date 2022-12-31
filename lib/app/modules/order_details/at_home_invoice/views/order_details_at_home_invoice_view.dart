import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:screenshot/screenshot.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/list_tile/divider_list_tile.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../controllers/order_details_at_home_invoice_controller.dart';

class OrderDetailsAtHomeInvoiceView
    extends GetView<OrderDetailsAtHomeInvoiceController> {
  const OrderDetailsAtHomeInvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchTransactionData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return onDataDone();
        }
        return onDataLoading();
      },
    );
  }

  Widget onDataLoading() {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset('assets/rive/loading.riv'),
      ),
    );
  }

  Widget onDataDone() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Order'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: const RiveAnimation.asset(
                          'assets/rive/checkmark_icon.riv'),
                    ),
                    _detailInvoice(),
                    const SizedBox(height: 24),
                    _actionButtons(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: ColorsTheme.neutralColor[900],
              child: OutlinedButton(
                onPressed: () {
                  controller.onBackToHome();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorsTheme.neutralColor[900],
                  backgroundColor: ColorsTheme.primaryColor,
                ),
                child: Text(
                  "Kembali ke Home",
                  style: TypographyTheme.buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailInvoice() {
    return Screenshot(
      controller: controller.screenshotController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Data Rental",
              style: TypographyTheme.titleSmall.copyWith(
                color: ColorsTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            DividerListTile(
              title: "ID Rental",
              trailing: Text(controller.orderAtHomeDetail.rentalId!),
              topBorder: true,
            ),
            DividerListTile(
              title: "Total",
              trailing:
                  Text(controller.orderAtHomeDetail.totalAmount!.toRupiah()),
              topBorder: true,
            ),
            DividerListTile(
              title: "Metode Pembayaran",
              trailing: Text(
                  controller.orderAtHomeDetail.paymentMethod!.toTitleCase()),
              topBorder: true,
            ),
            DividerListTile(
              title: "Game Center",
              trailing: Container(
                alignment: Alignment.centerRight,
                width: 180,
                child: Text(
                  controller.orderAtHomeDetail.location!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Playstation",
              trailing: Text(
                  controller.orderAtHomeDetail.playstationType!.toTitleCase()),
              topBorder: true,
            ),
            DividerListTile(
              title: "Metode Pengiriman",
              trailing: Text(controller.shipmentMethod),
              topBorder: true,
            ),
            DividerListTile(
              title: "Status",
              trailing: Text(controller.status),
              topBorder: true,
              bottomBorder: true,
            ),
            const SizedBox(height: 32),
            _addressBuilder(),
            Text(
              "Detail Catatan",
              style: TypographyTheme.titleSmall.copyWith(
                color: ColorsTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                controller.orderAtHomeDetail.description!.isNotEmpty
                    ? controller.orderAtHomeDetail.description!
                    : "Tidak ada detail Catatan",
                style: TypographyTheme.bodyRegular,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Detail Waktu Main",
              style: TypographyTheme.titleSmall.copyWith(
                color: ColorsTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            DividerListTile(
              title: "Tanggal Transaksi",
              trailing: Text(DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                  .format(controller.orderAtHomeDetail.orderTime!.toLocal())),
              topBorder: true,
            ),
            DividerListTile(
              title: "Jam Transaksi",
              trailing: Text(DateFormat("Hm", "id_ID")
                  .format(controller.orderAtHomeDetail.orderTime!.toLocal())),
              topBorder: true,
            ),
            DividerListTile(
              title: "Playtime",
              trailing: Text("${controller.orderAtHomeDetail.playtime} Hari"),
              topBorder: true,
            ),
            DividerListTile(
              title: "Tanggal Mulai Main",
              trailing: Text(
                DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                    .format(controller.orderAtHomeDetail.startTime!.toLocal()),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Tanggal Selesai Main",
              trailing: Text(
                DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                    .format(controller.orderAtHomeDetail.endTime!.toLocal()),
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

  Widget _addressBuilder() {
    return controller.orderAtHomeDetail.address!.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alamat",
                style: TypographyTheme.titleSmall.copyWith(
                  color: ColorsTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  controller.orderAtHomeDetail.address!,
                  style: TypographyTheme.bodyRegular,
                ),
              ),
              const SizedBox(height: 32),
            ],
          )
        : const SizedBox();
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
