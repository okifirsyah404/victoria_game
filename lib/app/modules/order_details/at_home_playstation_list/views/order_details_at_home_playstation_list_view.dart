import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../controllers/order_details_at_home_playstation_list_controller.dart';

class OrderDetailsAtHomePlaystationListView
    extends GetView<OrderDetailsAtHomePlaystationListController> {
  const OrderDetailsAtHomePlaystationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Playstation'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchAvailablePlaystations(),
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          width: Get.width,
          color: ColorsTheme.neutralColor[900],
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorsTheme.neutralColor[800],
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Waktu Main Yang Kamu Pilih",
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                    "${DateFormat("dd MMMM yyyy", "id_ID").format(controller.startDate)} - ${DateFormat("dd MMMM yyyy", "id_ID").format(controller.finishDate)}"),
              ],
            ),
          ),
        ),
        _playstationListBuilder(),
      ],
    );
  }

  Widget _playstationListBuilder() {
    return controller.availablePlaystationList.isNotEmpty ? Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 160 / 60,
        ),
        shrinkWrap: true,
        itemCount: controller.availablePlaystationList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            controller.onSelectedPlaystationItem(index);
          },
          child: Material(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: ColorsTheme.primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.availablePlaystationList[index].playstationType?.toTitleCase()}"
                        .toTitleCase(),
                    style: TypographyTheme.bodyMedium.copyWith(
                      color: ColorsTheme.neutralColor[900],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${controller.availablePlaystationList[index].status}"
                        .toTitleCase(),
                    style: TypographyTheme.bodySmall.copyWith(
                      color: ColorsTheme.neutralColor[900],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ) : Container(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: Container(
          height: 200,
          width: 200,
          child: const Icon(CustomIconData.joystick),
        ),
      ),
    );
  }
}
