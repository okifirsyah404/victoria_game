import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../controllers/main_page_rent_controller.dart';

class MainPageRentView extends GetView<MainPageRentController> {
  const MainPageRentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchPlaystationList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return onDataDone();
        }
        return onDataLoading();
      },
    );
  }

  Widget onDataLoading() {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset('assets/rive/loading.riv'),
      ),
    );
  }

  Widget onDataDone() {
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
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TypographyTheme.bodyRegular,
                children: [
                  const TextSpan(
                      text:
                          "Sewa Playstation untuk main di rumah kamu? Hanya di Game Center "),
                  TextSpan(
                    text: "Tolonto Game Bojonegoro",
                    style: TypographyTheme.bodyRegular.copyWith(
                        color: ColorsTheme.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(text: ". Mainkan di rumahmu sekarang!"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _playstationTypeBuilder(),
        ],
      ),
      bottomNavigationBar: const MainBottomNavigation(),
    );
  }

  Widget _playstationTypeBuilder() {
    return Expanded(
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
                        controller.playstationList[index].playstationTypeName!
                            .toTitleCase(),
                        style: TypographyTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          Text(
                            int.parse(controller.playstationList[index].price!
                                    .toString())
                                .toRupiah(),
                            style: TypographyTheme.bodyMedium.copyWith(
                              color: ColorsTheme.primaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "/hari",
                            style: TypographyTheme.bodySmall.copyWith(
                              color: ColorsTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        controller.playstationList[index].available! > 0
                            ? "Tersedia ${controller.playstationList[index].available!} Unit"
                            : "Unit Habis",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
