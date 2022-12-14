import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/dropdown/generic_dropdown.dart';
import 'package:victoria_game/app/global/widgets/text_field/show_modal_text_field/views/show_modal_text_field.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

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
      body: FutureBuilder(
        future: controller.fetchItemData(),
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
    return Form(
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
                        padding: const EdgeInsets.only(bottom: 8.0),
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
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.itemData.playstationTypeName!
                                      .toTitleCase(),
                                  style: TypographyTheme.bodyMedium,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      int.parse(controller.itemData.price
                                              .toString())
                                          .toRupiah(),
                                      style:
                                          TypographyTheme.bodyMedium.copyWith(
                                        color: ColorsTheme.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      " /hari",
                                      style: TypographyTheme.bodySmall.copyWith(
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
                        padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                        child: Text(
                          "Waktu Main",
                          style: TypographyTheme.titleSmall,
                        ),
                      ),
                      ShowModalTextField(
                        controller: controller.calendarTextController,
                        onTap: () {
                          controller.openDatePicker();
                        },
                        label: "Rentang Waktu Main",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                        child: Text(
                          "Pembayaran",
                          style: TypographyTheme.titleSmall,
                        ),
                      ),
                      _paymentMethod(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _paymentMethod() {
    return Obx(
      () => controller.paymentMethod.value != ""
          ? ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              tileColor: ColorsTheme.neutralColor[900],
              textColor: ColorsTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              title: Text(
                controller.paymentMethod.value,
                style: TypographyTheme.titleSmall,
              ),
              trailing: controller.paymentMethodBallance.value > 0
                  ? Text(
                      controller.paymentMethodBallance.value.toRupiah(),
                      style: TypographyTheme.bodyRegular,
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
                foregroundColor: ColorsTheme.primaryColor,
                backgroundColor: ColorsTheme.neutralColor[800],
                side: BorderSide(
                  color: ColorsTheme.primaryColor,
                ),
              ),
              child: const Text("Pilih Pembayaran"),
            ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: Get.width,
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
              Obx(
                () => Text(
                  int.parse(controller.totalAmount.value.toString()).toRupiah(),
                  style: TypographyTheme.bodyMedium.copyWith(
                    color: ColorsTheme.primaryColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              controller.onSumbit();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorsTheme.neutralColor[900],
              backgroundColor: ColorsTheme.primaryColor,
              side: BorderSide(
                color: ColorsTheme.primaryColor,
              ),
            ),
            child: const Text("Pilih Playstation"),
          ),
        ],
      ),
    );
  }
}
