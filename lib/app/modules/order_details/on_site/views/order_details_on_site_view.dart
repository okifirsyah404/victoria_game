import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/buttons_theme.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/dropdown/generic_dropdown.dart';
import 'package:victoria_game/app/global/widgets/text_field/regular_text_field/views/regular_text_field_widget.dart';
import 'package:victoria_game/app/global/widgets/text_field/show_modal_text_field/views/show_modal_text_field.dart';
import 'package:victoria_game/app/global/widgets/text_field/username_text_field/views/username_text_field_widget.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/order_details_on_site_controller.dart';

class OrderDetailsOnSiteView extends GetView<OrderDetailsOnSiteController> {
  const OrderDetailsOnSiteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchInitialOrderData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return onDataDone(context);
          }
          return onDataLoading();
        },
      ),
    );
  }

  Widget onDataLoading() {
    return Center(
      child: RiveAnimation.asset('assets/rive/loading.riv'),
    );
  }

  Widget onDataDone(BuildContext context) {
    return Obx(() {
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Game Center",
                      style: TypographyTheme.titleSmall,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 328 / 90,
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.gameCenterName,
                              style: TypographyTheme.titleSmall.copyWith(
                                color: ColorsTheme.primaryColor,
                              ),
                            ),
                            Text(
                              controller.gameCenterAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TypographyTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.playstationType.toTitleCase(),
                              style: TypographyTheme.bodyRegular,
                            ),
                            Text(
                              controller.playstationId,
                              style: TypographyTheme.titleSmall.copyWith(
                                color: ColorsTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _scheduledTime(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                    child: Text(
                      "Waktu Main",
                      style: TypographyTheme.titleSmall,
                    ),
                  ),
                  ShowModalTextField(
                    controller: controller.calendarTextController,
                    icon: Icon(
                      CustomIconData.calendar,
                      color: ColorsTheme.neutralColor[900],
                    ),
                    onTap: () {
                      controller.openDatePicker(context);
                    },
                    label: "Tanggal Main",
                  ),
                  SizedBox(height: 8),
                  ShowModalTextField(
                    controller: controller.timeTextController,
                    icon: FaIcon(
                      FontAwesomeIcons.clock,
                      color: ColorsTheme.neutralColor[900],
                    ),
                    onTap: () {
                      controller.openTimePicker(context);
                    },
                    label: "Jam Main",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                    child: Text(
                      "Durasi Main",
                      style: TypographyTheme.titleSmall,
                    ),
                  ),
                  GenericDropdown(
                      selectedItem: controller.dropDownInitialSelected.value,
                      icon: Icon(
                        CustomIconData.timer,
                        color: ColorsTheme.neutralColor[900],
                      ),
                      items: controller.listItem,
                      onChanged: (val) {
                        controller.onChangeDropDown(val);
                      }),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                    child: Text(
                      "Pembayaran",
                      style: TypographyTheme.titleSmall,
                    ),
                  ),
                  _inititatePaymentMethod(),
                ],
              ),
            ),
            _submitBottom(),
          ],
        ),
      );
    });
  }

  Widget _inititatePaymentMethod() {
    return controller.paymentMethod.value != ""
        ? ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
            child: Text("Pilih Pembayaran"),
          );
  }

  Widget _submitBottom() {
    return Container(
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
                controller.totalAmount.toRupiah(),
                style: TypographyTheme.bodyMedium.copyWith(
                  color: ColorsTheme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              controller.submitOrder();
            },
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
    );
  }

  Widget _scheduledTime() {
    return controller.scheduledTimeListDetail.isNotEmpty
        ? Column(
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
                      "Waktu Telah Dirental",
                      style: TypographyTheme.titleSmall,
                    ),
                    InkWell(
                      onTap: () {
                        controller.submitToScheduleScreen();
                      },
                      child: Text(
                        "Lihat Semua",
                        style: TypographyTheme.bodySmall
                            .copyWith(color: ColorsTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemCount: (controller.scheduledTimeListDetail.length > 6)
                    ? 6
                    : controller.scheduledTimeListDetail.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: controller.scheduledTimeListDetail[index]
                              ["isPlaying"]
                          ? ColorsTheme.errorColor[500]
                          : ColorsTheme.primaryColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${controller.scheduledTimeListDetail[index]["date"]}",
                          style: TypographyTheme.bodyRegular.copyWith(
                              color: ColorsTheme.neutralColor[900],
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${controller.scheduledTimeListDetail[index]["firstTime"]}",
                              style: TypographyTheme.bodyRegular.copyWith(
                                  color: ColorsTheme.neutralColor[900]),
                            ),
                            Text(
                              " - ",
                              style: TypographyTheme.bodyRegular.copyWith(
                                  color: ColorsTheme.neutralColor[900]),
                            ),
                            Text(
                              "${controller.scheduledTimeListDetail[index]["lastTime"]}",
                              style: TypographyTheme.bodyRegular.copyWith(
                                  color: ColorsTheme.neutralColor[900]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
        : const SizedBox();
  }
}
