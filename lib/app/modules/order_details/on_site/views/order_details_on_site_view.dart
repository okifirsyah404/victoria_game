import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/buttons_theme.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/dropdown/generic_dropdown.dart';
import 'package:victoria_game/app/global/widgets/text_field/regular_text_field/views/regular_text_field_widget.dart';
import 'package:victoria_game/app/global/widgets/text_field/show_modal_text_field/views/show_modal_text_field.dart';
import 'package:victoria_game/app/global/widgets/text_field/username_text_field/views/username_text_field_widget.dart';

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
      body: Column(
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
                            "Tolonto Game Bojonegoro",
                            style: TypographyTheme.titleSmall.copyWith(
                              color: ColorsTheme.primaryColor,
                            ),
                          ),
                          Text(
                            "Alamat",
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
                            "Playstation 3",
                            style: TypographyTheme.bodyRegular,
                          ),
                          Text(
                            "No. 1",
                            style: TypographyTheme.titleSmall.copyWith(
                              color: ColorsTheme.primaryColor,
                            ),
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
                Obx(
                  () => GenericDropdown(
                      selectedItem: controller.dropDownInitialSelected.value,
                      // items: [
                      //   controller.dropDownInitialSelected.value,
                      //   ...controller.listItem
                      // ],
                      items: controller.listItem,
                      onChanged: (val) {
                        controller.onChangeDropDown(val);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                  child: Text(
                    "Pembayaran",
                    style: TypographyTheme.titleSmall,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorsTheme.primaryColor,
                    backgroundColor: ColorsTheme.neutralColor[800],
                    side: BorderSide(
                      color: ColorsTheme.primaryColor,
                    ),
                  ),
                  child: Text("Pilih Pembayaran"),
                )
              ],
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
                      "Rp -",
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
    );
  }
}
