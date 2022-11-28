import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/dropdown/generic_dropdown.dart';
import 'package:victoria_game/app/global/widgets/text_field/show_modal_text_field/views/show_modal_text_field.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/int_extensions.dart';

import '../../../../global/themes/colors_theme.dart';
import '../controllers/order_details_at_home_controller.dart';

class OrderDetailsAtHomeView extends GetView<OrderDetailsAtHomeController> {
  const OrderDetailsAtHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isPageLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 16.0),
                                child: Text(
                                  "Nomor Playstation",
                                  style: TypographyTheme.titleSmall,
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 328 / 80,
                                child: Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.itemData["playstation"],
                                          style: TypographyTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              int.parse(controller
                                                      .itemData["price"]
                                                      .toString())
                                                  .toRupiah(),
                                              style: TypographyTheme.bodyMedium
                                                  .copyWith(
                                                color: ColorsTheme.primaryColor,
                                              ),
                                            ),
                                            Text(
                                              " /hari",
                                              style: TypographyTheme.bodySmall
                                                  .copyWith(
                                                color: ColorsTheme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 16.0),
                                child: Text(
                                  "Waktu Main",
                                  style: TypographyTheme.titleSmall,
                                ),
                              ),
                              ShowModalTextField(
                                controller:
                                    controller.initCalendarTextController,
                                icon: Icon(
                                  CustomIconData.calendar,
                                  color: ColorsTheme.neutralColor[900],
                                ),
                                onTap: () {
                                  controller.initTimePicked(context);
                                },
                                label: "Tanggal Mulai Main",
                              ),
                              SizedBox(height: 8),
                              ShowModalTextField(
                                controller:
                                    controller.endCalendarTextController,
                                icon: Icon(
                                  CustomIconData.calendar,
                                  color: ColorsTheme.neutralColor[900],
                                ),
                                onTap: () {
                                  controller.endTimePicked(context);
                                },
                                label: "Tanggal Selesai Main",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 16.0),
                                child: Text(
                                  "Pembayaran",
                                  style: TypographyTheme.titleSmall,
                                ),
                              ),
                              controller.paymentMethod.value != ""
                                  ? ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      tileColor: ColorsTheme.neutralColor[900],
                                      textColor: ColorsTheme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      title: Text(
                                        controller.paymentMethod.value,
                                        style: TypographyTheme.titleSmall,
                                      ),
                                      trailing: controller
                                                  .paymentMethodBallance.value >
                                              0
                                          ? Text(
                                              controller
                                                  .paymentMethodBallance.value
                                                  .toRupiah(),
                                              style:
                                                  TypographyTheme.bodyRegular,
                                            )
                                          : null,
                                      onTap: () {
                                        controller.initiatePaymentMethod();
                                      },
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        controller.initiatePaymentMethod();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor:
                                            ColorsTheme.primaryColor,
                                        backgroundColor:
                                            ColorsTheme.neutralColor[800],
                                        side: BorderSide(
                                          color: ColorsTheme.primaryColor,
                                        ),
                                      ),
                                      child: Text("Pilih Pembayaran"),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 16.0),
                                child: Text(
                                  "Pengiriman",
                                  style: TypographyTheme.titleSmall,
                                ),
                              ),
                              if (controller.shipmentData == null)
                                OutlinedButton(
                                  onPressed: () {
                                    controller.initiateShipmentMethod();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: ColorsTheme.primaryColor,
                                    backgroundColor:
                                        ColorsTheme.neutralColor[800],
                                    side: BorderSide(
                                      color: ColorsTheme.primaryColor,
                                    ),
                                  ),
                                  child: Text("Pilih Metode Pengiriman"),
                                )
                              else
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 10.0),
                                  tileColor: ColorsTheme.neutralColor[900],
                                  textColor: ColorsTheme.primaryColor,
                                  selectedColor: ColorsTheme.neutralColor[900],
                                  selectedTileColor: ColorsTheme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      controller.shipmentData?["methodTitle"],
                                      style: TypographyTheme.titleSmall,
                                    ),
                                  ),
                                  subtitle: Text(
                                    controller.shipmentData?["description"],
                                    style: TypographyTheme.bodySmall.copyWith(
                                      color: ColorsTheme.neutralColor[50],
                                    ),
                                  ),
                                  onTap: () {
                                    controller.initiateShipmentMethod();
                                  },
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
                    color: ColorsTheme.neutralColor[900],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TypographyTheme.bodySmall,
                            ),
                            Text(
                              int.parse(controller.totalAmount.value.toString())
                                  .toRupiah(),
                              style: TypographyTheme.bodyMedium.copyWith(
                                color: ColorsTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: ColorsTheme.neutralColor[900],
                            backgroundColor: ColorsTheme.primaryColor,
                            side: BorderSide(
                              color: ColorsTheme.primaryColor,
                            ),
                          ),
                          child: Text("Checkout"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
