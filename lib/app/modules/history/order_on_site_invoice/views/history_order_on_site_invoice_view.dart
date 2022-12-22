import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/list_tile/divider_list_tile.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../controllers/history_order_on_site_invoice_controller.dart';

class HistoryOrderOnSiteInvoiceView
    extends GetView<HistoryOrderOnSiteInvoiceController> {
  const HistoryOrderOnSiteInvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Rental'),
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
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardBuilder(),
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
              trailing: Text(controller.detailTransactionDataHistory.rentalId),
              topBorder: true,
            ),
            DividerListTile(
              title: "Total",
              trailing: Text(controller.detailTransactionDataHistory.totalAmount
                  .toRupiah()),
              topBorder: true,
            ),
            DividerListTile(
              title: "Metode Pembayaran",
              trailing: Text(controller
                  .detailTransactionDataHistory.paymentMethod
                  .toTitleCase()),
              topBorder: true,
            ),
            DividerListTile(
              title: "Game Center",
              trailing: Container(
                alignment: Alignment.centerRight,
                width: 180,
                child: Text(
                  controller.detailTransactionDataHistory.gameCenter,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Lokasi Game Center",
              trailing: Text(
                  controller.detailTransactionDataHistory.gameCenterLocation),
              topBorder: true,
            ),
            DividerListTile(
              title: "Playstation",
              trailing: Text(controller
                  .detailTransactionDataHistory.playstationType
                  .toTitleCase()),
              topBorder: true,
            ),
            DividerListTile(
              title: "Nomor Playstation",
              trailing:
                  Text(controller.detailTransactionDataHistory.playstationId),
              topBorder: true,
              bottomBorder: true,
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
              title: "Playtime",
              trailing: Text(
                  "${controller.detailTransactionDataHistory.playtime} Jam"),
              topBorder: true,
            ),
            DividerListTile(
              title: "Tanggal Main",
              trailing: Text(
                DateFormat("dd MMMM yyyy", "id_ID").format(controller
                    .detailTransactionDataHistory.startTime
                    .toLocal()),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              topBorder: true,
            ),
            DividerListTile(
              title: "Jam Main",
              trailing: Text(DateFormat("Hm", "id_ID").format(
                  controller.detailTransactionDataHistory.startTime.toLocal())),
              topBorder: true,
              bottomBorder: true,
            ),
            SizedBox(height: 24),
            _actionButtons(),
            SizedBox(height: 16),
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
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorsTheme.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.detailTransactionDataHistory.playstationType
                      .toTitleCase(),
                  style: TypographyTheme.bodyMedium.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  controller.detailTransactionDataHistory.totalAmount
                      .toRupiah(),
                  style: TypographyTheme.bodyMedium.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              color: ColorsTheme.neutralColor[800],
              height: 8,
            ),
            const SizedBox(height: 8),
            Text(
              controller.detailTransactionDataHistory.gameCenter,
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
                  DateFormat("dd MMMM yyyy", "id_ID").format(controller
                      .detailTransactionDataHistory.orderTime
                      .toLocal()),
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _countdownTimerBuilder()
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
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
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
        SizedBox(width: 24),
        InkWell(
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
        SizedBox(width: 24),
        InkWell(
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

  Widget _countdownTimerBuilder() {
    return controller.isCurrentPlaying.value
        ? CountdownTimer(
            controller: controller.countdownTimerController,
            widgetBuilder: (_, time) {
              if (time != null) {
                if (time.hours != null) {
                  return Text(
                      "${time.hours} Jam ${time.min} Menit ${time.sec} Detik",
                      style: TypographyTheme.bodyRegular.copyWith(
                        color: ColorsTheme.neutralColor[900],
                        fontWeight: FontWeight.w600,
                      ));
                }

                if (time.min != null) {
                  return Text("${time.min} Menit ${time.sec} Detik",
                      style: TypographyTheme.bodyRegular.copyWith(
                        color: ColorsTheme.neutralColor[900],
                        fontWeight: FontWeight.w600,
                      ));
                }

                return Text("${time.sec} Detik",
                    style: TypographyTheme.bodyRegular.copyWith(
                      color: ColorsTheme.neutralColor[900],
                      fontWeight: FontWeight.w600,
                    ));
              }

              return const SizedBox();
            },
          )
        : Text(
            controller.detailTransactionDataHistory.timeInterval,
            style: TypographyTheme.bodyRegular.copyWith(
              color: ColorsTheme.neutralColor[900],
              fontWeight: FontWeight.w600,
            ),
          );
  }
}
