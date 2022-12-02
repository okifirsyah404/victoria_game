import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/text_field/show_modal_text_field/views/show_modal_text_field.dart';
import 'package:victoria_game/utils/int_extensions.dart';

import '../controllers/order_details_at_home_overview_controller.dart';

class OrderDetailsAtHomeOverviewView
    extends GetView<OrderDetailsAtHomeOverviewController> {
  const OrderDetailsAtHomeOverviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Overview'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isPageLoading.value
          ? const Center(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Playstation",
                                style: TypographyTheme.titleSmall,
                              ),
                            ),
                            AspectRatio(
                              aspectRatio: 328 / 80,
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
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
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Waktu Main",
                                    style: TypographyTheme.titleSmall,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.onTimeAndPaymentChange();
                                    },
                                    child: Text(
                                      "Ubah",
                                      style: TypographyTheme.bodySmall.copyWith(
                                        color: ColorsTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AspectRatio(
                              aspectRatio: 100 / 22,
                              child: Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 2,
                                child: Container(
                                  width: Get.width,
                                  // height: 64,5
                                  decoration: BoxDecoration(
                                    color: ColorsTheme.neutralColor[900],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tanggal Mulai Main",
                                              style: TypographyTheme.bodySmall,
                                            ),
                                            Text(
                                              controller.startDate.value,
                                              style: TypographyTheme.bodyRegular
                                                  .copyWith(
                                                color: ColorsTheme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 20,
                                        thickness: 1,
                                        color: ColorsTheme.neutralColor[50],
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tanggal Selesai Main",
                                              style: TypographyTheme.bodySmall,
                                            ),
                                            Text(
                                              controller.lastDate.value,
                                              style: TypographyTheme.bodyRegular
                                                  .copyWith(
                                                color: ColorsTheme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Metode Pembayaran",
                                    style: TypographyTheme.titleSmall,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.onTimeAndPaymentChange();
                                    },
                                    child: Text(
                                      "Ubah",
                                      style: TypographyTheme.bodySmall.copyWith(
                                        color: ColorsTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                              tileColor: ColorsTheme.neutralColor[900],
                              textColor: ColorsTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              title: Text(
                                controller.paymentMethod?.value ?? "",
                                // "Tunai",
                                style: TypographyTheme.titleSmall,
                              ),
                              trailing:
                                  (controller.paymentMethodBallance?.value ??
                                              0) >
                                          0
                                      ? Text(
                                          (controller.paymentMethodBallance
                                                      ?.value ??
                                                  0)
                                              .toRupiah(),
                                          style: TypographyTheme.bodyRegular,
                                        )
                                      : null,
                            ),
                            shipmentWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
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
                              (controller.totalAmount ?? 0).toRupiah(),
                              style: TypographyTheme.bodyMedium.copyWith(
                                color: ColorsTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          // TODO: ON SUBMIT CHECKOUT
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: ColorsTheme.neutralColor[900],
                            backgroundColor: ColorsTheme.primaryColor,
                            side: BorderSide(
                              color: ColorsTheme.primaryColor,
                            ),
                          ),
                          child: const Text("Checkout"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  Widget shipmentWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Metode Pengiriman",
                style: TypographyTheme.titleSmall,
              ),
              InkWell(
                onTap: () {
                  controller.onShipmentMethodChange();
                },
                child: Text(
                  "Ubah",
                  style: TypographyTheme.bodySmall.copyWith(
                    color: ColorsTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          tileColor: ColorsTheme.neutralColor[900],
          textColor: ColorsTheme.primaryColor,
          selectedColor: ColorsTheme.neutralColor[900],
          selectedTileColor: ColorsTheme.primaryColor,
          // selected: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              controller.shipmentMethod?.value ?? "",
              style: TypographyTheme.titleSmall,
            ),
          ),
          subtitle: Text(
            controller.shipmentMethodDescription?.value ?? "",
            style: TypographyTheme.bodySmall.copyWith(
              color: ColorsTheme.neutralColor[50],
            ),
          ),
        ),
        controller.shipmentMethod?.value != "Shipment by Official"
            ? const SizedBox()
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                    child: Text(
                      "Lokasi Pengiriman",
                      style: TypographyTheme.titleSmall,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 328 / 148,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.3,
                        widthFactor: 2.5,
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: false,
                          markers: Set.from(controller.myMarker),
                          onMapCreated: (googleMapController) {
                            controller.onMapCreated(googleMapController);
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(controller.markedLatitude.value,
                                controller.markedLongitude.value),
                            zoom: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
