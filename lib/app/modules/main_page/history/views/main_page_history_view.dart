import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

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
      ),
      body: SafeArea(
        child: Column(
          children: [
            _mainTabBarBuilder(),
            Expanded(
              child: _mainTabView(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }

  Widget _mainTabBarBuilder() {
    return Container(
      decoration: BoxDecoration(
        color: ColorsTheme.neutralColor[900],
      ),
      height: 48,
      width: Get.width,
      child: TabBar(
        controller: controller.mainTabController,
        isScrollable: true,
        indicatorColor: ColorsTheme.primaryColor,
        indicator: BoxDecoration(
          color: ColorsTheme.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        labelColor: ColorsTheme.neutralColor[900],
        unselectedLabelColor: ColorsTheme.primaryColor,
        padding: const EdgeInsets.all(8),
        tabs: controller.mainTab,
      ),
    );
  }

  Widget _mainTabView() {
    return TabBarView(
      controller: controller.mainTabController,
      children: [
        _rentOnSiteViewBuilder(),
        Text("Test 2"),
        Text("Test 3"),
      ],
    );
  }

  Widget _cardItemBuilder({
    required String productName,
    required String transactionId,
    required String gameCenter,
    required int totalAmount,
    required DateTime transactionDate,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                  productName.toTitleCase(),
                  style: TypographyTheme.bodyMedium.copyWith(
                    color: ColorsTheme.primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  transactionId,
                  style: TypographyTheme.bodySmall,
                ),
                SizedBox(height: 4),
                Text(
                  gameCenter.toTitleCase(),
                  style: TypographyTheme.bodyRegular.copyWith(),
                ),
                SizedBox(height: 8),
                Divider(
                  color: ColorsTheme.neutralColor,
                  height: 8,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      totalAmount.toRupiah(),
                      style: TypographyTheme.titleSmall.copyWith(
                        color: ColorsTheme.primaryColor,
                      ),
                    ),
                    Text(
                      DateFormat("dd MMMM yyyy", "id_ID")
                          .format(transactionDate.toLocal()),
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
  }

  Widget _rentOnSiteActiveIndicator(
      {required String playstationType, required int playtime}) {
    return Obx(
      () => controller.isRentOnSiteActive.value
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              color: ColorsTheme.neutralColor[900],
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                  top: 4,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          playstationType.toTitleCase(),
                          style: TypographyTheme.bodyMedium.copyWith(
                            color: ColorsTheme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Playtime $playtime Jam",
                              style: TypographyTheme.bodySmall,
                            ),
                            CountdownTimer(
                              controller: controller.countdownTimerController,
                              onEnd: () {
                                controller.onCountdownDone();
                              },
                              widgetBuilder: (_, time) {
                                if (time != null) {
                                  if (time.hours != null) {
                                    return Text(
                                        "${time.hours} Jam ${time.min} Menit ${time.sec} Detik",
                                        style: TypographyTheme.bodySmall);
                                  }

                                  if (time.min != null) {
                                    return Text(
                                        "${time.min} Menit ${time.sec} Detik",
                                        style: TypographyTheme.bodySmall);
                                  }

                                  return Text("${time.sec} Detik",
                                      style: TypographyTheme.bodySmall);
                                }

                                return Text("Hola",
                                    style: TypographyTheme.bodySmall);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _secondaryTabBarBuilder({required TabController tabController}) {
    return Material(
      elevation: 4,
      child: Container(
        height: 48,
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorsTheme.neutralColor[900],
        ),
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: ColorsTheme.primaryColor,
          indicator: BoxDecoration(
            color: ColorsTheme.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          labelColor: ColorsTheme.neutralColor[900],
          unselectedLabelColor: ColorsTheme.primaryColor,
          padding: const EdgeInsets.all(8),
          tabs: controller.secondaryTab,
        ),
      ),
    );
  }

  Widget _rentOnSiteViewBuilder() {
    return FutureBuilder(
      future: controller.fetchOrderOnSiteHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              TabBarView(
                  controller: controller.playOnSiteTabController,
                  children: [
                    _futureRentOnSiteListItems(),
                    _previousRentOnSiteListItems(),
                  ]),
              _secondaryTabBarBuilder(
                  tabController: controller.playOnSiteTabController),
            ],
          );
        }
        return const Center(
          child: RiveAnimation.asset('assets/rive/loading.riv'),
        );
      },
    );
  }

  Widget _futureRentOnSiteListItems() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: 64,
              bottom: 16,
            ),
            shrinkWrap: true,
            itemCount: controller.futurePlayOnSiteHistoryList.length,
            itemBuilder: (context, index) => _cardItemBuilder(
              productName: controller.futurePlayOnSiteHistoryList[index]
                  ["playstationType"],
              transactionId: controller.futurePlayOnSiteHistoryList[index]
                  ["rentalId"],
              totalAmount: controller.futurePlayOnSiteHistoryList[index]
                  ["totalAmount"],
              transactionDate: controller.futurePlayOnSiteHistoryList[index]
                  ["orderDate"],
              gameCenter: controller.futurePlayOnSiteHistoryList[index]
                  ["gameCenter"],
            ),
          ),
        ),
        _rentOnSiteActiveIndicator(
          playstationType: controller.currentOnSitePlaying["playstationType"],
          playtime: controller.currentOnSitePlaying["playtime"],
        ),
      ],
    );
  }

  Widget _previousRentOnSiteListItems() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              top: 64,
              bottom: 100,
            ),
            shrinkWrap: true,
            itemCount: controller.previousPlayOnSiteHistoryList.length,
            itemBuilder: (context, index) => _cardItemBuilder(
              productName: controller.previousPlayOnSiteHistoryList[index]
                  ["playstationType"],
              transactionId: controller.previousPlayOnSiteHistoryList[index]
                  ["rentalId"],
              totalAmount: controller.previousPlayOnSiteHistoryList[index]
                  ["totalAmount"],
              transactionDate: controller.previousPlayOnSiteHistoryList[index]
                  ["orderDate"],
              gameCenter: controller.previousPlayOnSiteHistoryList[index]
                  ["gameCenter"],
              onTap: () {
                controller.onTapPreviousOrderOnSiteHistoryItem(index);
              },
            ),
          ),
        ),
        _rentOnSiteActiveIndicator(
          playstationType: controller.currentOnSitePlaying["playstationType"],
          playtime: controller.currentOnSitePlaying["playtime"],
        ),
      ],
    );
  }
}
