import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/themes/colors_theme.dart';
import '../../../../global/themes/typography_theme.dart';
import '../../../../global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import '../controllers/main_page_history_controller.dart';

class MainPageHistoryView extends GetView<MainPageHistoryController> {
  const MainPageHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat',
          style: TypographyTheme.titleRegular.copyWith(
            color: ColorsTheme.primaryColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        return Stack(
          children: [
            ListView.builder(
              itemCount: 30,
              padding: EdgeInsets.only(
                top: 16,
                bottom: 100,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: AspectRatio(
                    aspectRatio: 328 / 128,
                    child: Material(
                      elevation: 4,
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
                              "Playstation 4",
                              style: TypographyTheme.bodyMedium.copyWith(
                                color: ColorsTheme.primaryColor,
                              ),
                            ),
                            Text(
                              "INV/20221109/ytH2knF32HudnRG$index",
                              style: TypographyTheme.bodySmall,
                            ),
                            Divider(
                              color: ColorsTheme.neutralColor,
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Play Time 2 Hari",
                                  style: TypographyTheme.bodySmall,
                                ),
                                Text(
                                  "Rental di Rumah",
                                  style: TypographyTheme.bodySmall,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Rp 100.000",
                                  style: TypographyTheme.titleSmall.copyWith(
                                    color: ColorsTheme.primaryColor,
                                  ),
                                ),
                                Text(
                                  "Rabu, 09 September 2022",
                                  style: TypographyTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            controller.isRentActive.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        color: ColorsTheme.neutralColor[900],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rental Aktif",
                              style: TypographyTheme.bodySmall.copyWith(
                                color: ColorsTheme.primaryColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 7,
                              ),
                              child: AspectRatio(
                                aspectRatio: 328 / 64,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: ColorsTheme.neutralColor[800],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Playstation 3",
                                        style:
                                            TypographyTheme.bodyMedium.copyWith(
                                          color: ColorsTheme.primaryColor,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Playtime 2 Jam",
                                            style: TypographyTheme.bodySmall,
                                          ),
                                          Text(
                                            "1:20:29",
                                            style: TypographyTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        );
      }),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
