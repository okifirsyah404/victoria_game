import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:victoria_game/app/global/icons/custom_icon_data_icons.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import 'package:victoria_game/app/global/widgets/shimmer_widget.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/int_extensions.dart';

import '../controllers/main_page_home_controller.dart';

class MainPageHomeView extends GetView<MainPageHomeController> {
  const MainPageHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: controller.fetchUserData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return MainView();
    //     }

    //     return LoadingData();
    //   },
    // );

    return Scaffold(
      body: FutureBuilder(
        future: controller.initData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return mainView();
          }

          return loadingData();
        },
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }

  Widget loadingData() {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ShimmerWidget(
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: ColorsTheme.neutralColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ShimmerWidget(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorsTheme.neutralColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Hi, Lorem Ipsum Dolor",
                          style: TypographyTheme.bodyMedium
                              .copyWith(fontSize: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
                ShimmerWidget(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsTheme.neutralColor[900],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CustomIconData.setting,
                        color: ColorsTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerWidget(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorsTheme.neutralColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Saldo Kamu",
                                  style: TypographyTheme.bodySmall,
                                ),
                              ),
                            ),
                            ShimmerWidget(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorsTheme.neutralColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Rp 10.000.000",
                                  style: TypographyTheme.bodyMedium.copyWith(
                                    color: ColorsTheme.primaryColor,
                                  ),
                                ),
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
                            ShimmerWidget(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorsTheme.neutralColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Saldo Kamu",
                                  style: TypographyTheme.bodySmall,
                                ),
                              ),
                            ),
                            ShimmerWidget(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorsTheme.neutralColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Rp 10.000.000",
                                  style: TypographyTheme.bodyMedium.copyWith(
                                    color: ColorsTheme.primaryColor,
                                  ),
                                ),
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
            padding: const EdgeInsets.only(bottom: 16.0),
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
                  aspectRatio: 19 / 8,
                  child: SizedBox(
                    child: PageView.builder(
                      controller: PageController(
                        viewportFraction: 0.85,
                        initialPage: 0,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(8.0),
                            child: ShimmerWidget(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/placeholder/banner-images.jpg"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                  child: Text(
                    "Game Center",
                    style: TypographyTheme.titleSmall,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorsTheme.neutralColor[600],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShimmerWidget(
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorsTheme.neutralColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Nama Tempat Loading",
                            style: TypographyTheme.titleSmall.copyWith(
                              color: ColorsTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ShimmerWidget(
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorsTheme.neutralColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text(
                            "Alamat Tempat Loading, Lorem Ipsum Dolor Sit Amet Lalalalalalalalalalalala",
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mainView() {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
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
                            image: NetworkImage(
                                "https://82ad-114-125-84-49.ap.ngrok.io/api/user/image",
                                headers: {
                                  "Authorization": controller.authAccessToken,
                                }),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          "Hi, ${controller.username}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TypographyTheme.bodyMedium
                              .copyWith(fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                  padding: const EdgeInsets.symmetric(
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
                              controller.ballance.toRupiah(),
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
                              "${controller.playTime} Jam",
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
            padding: const EdgeInsets.only(bottom: 16.0),
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
                  aspectRatio: 19 / 8,
                  child: SizedBox(
                    child: PageView.builder(
                      controller: PageController(
                        viewportFraction: 0.85,
                        initialPage: 0,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_BANNER);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/placeholder/banner-images.jpg"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.DETAIL_GAME_CENTER,
                      //     arguments: controller.listItem[index]);
                    },
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorsTheme.neutralColor[600],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              controller.gameCenterList[index].name ?? "",
                              style: TypographyTheme.titleSmall.copyWith(
                                color: ColorsTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              controller.gameCenterList[index].address ?? "",
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemCount: controller.gameCenterList.length,
              ),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
