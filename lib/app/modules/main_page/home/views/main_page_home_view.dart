import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import 'package:victoria_game/app/modules/main_page/home/controllers/main_page_home_controller.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class MainPageHomeView extends GetView<MainPageHomeController> {
  const MainPageHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorsTheme.primaryColor,
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/drawable/profile/avatar-profile-100.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Hi, John Doe",
                          style: TypographyTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsTheme.neutralColor[900],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.PROFILE_SETTINGS_USER_PROFILE);
                        },
                        icon: Icon(
                          CustomIconData.setting,
                          color: ColorsTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: AspectRatio(
                  aspectRatio: 100 / 20,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Saldo Kamu",
                                  style: TypographyTheme.bodySmall,
                                ),
                                Text(
                                  "Rp 1.000.000",
                                  style: TypographyTheme.bodyMedium.copyWith(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Play Time Kamu",
                                  style: TypographyTheme.bodySmall,
                                ),
                                Text(
                                  "36 Jam",
                                  style: TypographyTheme.bodyMedium.copyWith(
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
              ),
              Container(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                      child: Text(
                        "Event",
                        style: TypographyTheme.titleSmall,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: SizedBox(
                        // height: 150,
                        child: PageView.builder(
                          controller: PageController(
                            viewportFraction: 0.85,
                            initialPage: 0,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Material(
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/placeholder/banner-images.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                    child: Text(
                      "Game Center",
                      style: TypographyTheme.titleSmall,
                    ),
                  ),
                  ...controller.listItem,
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
