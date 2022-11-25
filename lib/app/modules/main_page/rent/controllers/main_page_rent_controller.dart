import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../../../../global/themes/colors_theme.dart';
import '../../../../global/themes/typography_theme.dart';

class MainPageRentController extends GetxController {
  //TODO: Implement MainPageRentController

  var listItem = List.generate(
    2,
    (index) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.ORDER_DETAILS_AT_HOME);
        },
        child: AspectRatio(
          aspectRatio: 328 / 100,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorsTheme.neutralColor[600],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Playstation ${index + 3}",
                    style: TypographyTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        "Rp 100.000",
                        style: TypographyTheme.bodyMedium.copyWith(
                          color: ColorsTheme.primaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "/hari",
                        style: TypographyTheme.bodySmall.copyWith(
                          color: ColorsTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text("Alamat Tempat"),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
