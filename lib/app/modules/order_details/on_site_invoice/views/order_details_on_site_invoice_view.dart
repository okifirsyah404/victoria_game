import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/list_tile/divider_list_tile.dart';
import 'package:victoria_game/utils/int_extensions.dart';

import '../controllers/order_details_on_site_invoice_controller.dart';

class OrderDetailsOnSiteInvoiceView
    extends GetView<OrderDetailsOnSiteInvoiceController> {
  const OrderDetailsOnSiteInvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return onDataDone();
        // if (snapshot.connectionState == ConnectionState.done) {
        // }
        // return onDataLoading();
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
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
                      child:
                          RiveAnimation.asset('assets/rive/checkmark_icon.riv'),
                    ),
                    _detailInvoice(),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: ColorsTheme.neutralColor[900],
              child: OutlinedButton(
                onPressed: () {},
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
    return Padding(
      padding: EdgeInsets.all(16),
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
            trailing: Text("RT001-151222"),
            topBorder: true,
          ),
          DividerListTile(
            title: "Total",
            trailing: Text(100000.toRupiah()),
            topBorder: true,
          ),
          DividerListTile(
            title: "Game Center",
            trailing: Container(
              alignment: Alignment.centerRight,
              width: 180,
              child: Text(
                "Angkringan Tolonto Game Baureno",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            topBorder: true,
          ),
          DividerListTile(
            title: "Lokasi Game Center",
            trailing: Text("Bojonegoro"),
            topBorder: true,
          ),
          DividerListTile(
            title: "Playstation",
            trailing: Text("Playstation 4"),
            topBorder: true,
          ),
          DividerListTile(
            title: "Nomor Playstation",
            trailing: Text("No. 10"),
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
            trailing: Text("2 Jam"),
            topBorder: true,
          ),
          DividerListTile(
            title: "Tanggal Main",
            trailing: Text(
              "28 September 2022",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            topBorder: true,
          ),
          DividerListTile(
            title: "Jam Main",
            trailing: Text("12:10"),
            topBorder: true,
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.whatsapp),
            label: Text(
              "Ada Masalah? Hubungi Kami",
              style: TypographyTheme.buttonTextStyle,
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Color(0xFF25D366),
              foregroundColor: ColorsTheme.neutralColor[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
