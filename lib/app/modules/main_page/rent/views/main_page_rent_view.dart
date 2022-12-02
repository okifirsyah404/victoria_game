import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/int_extensions.dart';

import '../controllers/main_page_rent_controller.dart';

class MainPageRentView extends GetView<MainPageRentController> {
  const MainPageRentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sewa Playstation',
          style: TypographyTheme.titleRegular.copyWith(
            color: ColorsTheme.primaryColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            // child: Text(
            //   "Sewa Playstation untuk main di rumah kamu? Bisa nih. Penyewaan ini hanya berlaku di tempat",
            //   textAlign: TextAlign.center,
            // ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TypographyTheme.bodyRegular,
                children: [
                  TextSpan(
                      text:
                          "Sewa Playstation untuk main di rumah kamu? Hanya di Game Center "),
                  TextSpan(
                    text: "Tolonto Game Bojonegoro",
                    style: TypographyTheme.bodyRegular.copyWith(
                        color: ColorsTheme.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: ". Mainkan di rumahmu sekarang!"),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: controller.playstationList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: InkWell(
                  onTap: () {
                    controller.onItemTap(index);
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
                              controller.playstationList[index]["playstation"],
                              style: TypographyTheme.bodyMedium,
                            ),
                            Row(
                              children: [
                                Text(
                                  int.parse(controller.playstationList[index]
                                              ["price"]
                                          .toString())
                                      .toRupiah(),
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
                            Text(controller.playstationList[index]["stock"] > 0
                                ? "Stok ${controller.playstationList[index]["stock"]} Unit"
                                : "Stok Habis"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
