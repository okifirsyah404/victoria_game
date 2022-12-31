import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

import '../controllers/order_details_on_site_schedule_controller.dart';

class OrderDetailsOnSiteScheduleView
    extends GetView<OrderDetailsOnSiteScheduleController> {
  const OrderDetailsOnSiteScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Jadwal Rental Playstation No. ${int.parse(controller.playstationId.substring(4))}'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 16 / 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
        itemCount: controller.scheduledTimeListDetail.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: controller.scheduledTimeListDetail[index]["isPlaying"]
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
                      style: TypographyTheme.bodyRegular
                          .copyWith(color: ColorsTheme.neutralColor[900]),
                    ),
                    Text(
                      " - ",
                      style: TypographyTheme.bodyRegular
                          .copyWith(color: ColorsTheme.neutralColor[900]),
                    ),
                    Text(
                      "${controller.scheduledTimeListDetail[index]["lastTime"]}",
                      style: TypographyTheme.bodyRegular
                          .copyWith(color: ColorsTheme.neutralColor[900]),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
