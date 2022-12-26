import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/main_page_history_controller.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/order_on_site_history_controller.dart';
import 'package:victoria_game/app/modules/main_page/history/views/main_page_history_view.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class OrderOnSiteHistoryView extends GetWidget<OrderOnSiteHistoryController> {
  const OrderOnSiteHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchCurrentOnSitePlaying(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    TabBarView(
                        controller: controller.playOnSiteTabController,
                        children: const [
                          PreviousOrderOnSiteHistoryView(),
                          FutureOrderOnSiteHistoryView(),
                        ]),
                    _secondaryTabBarBuilder(
                        tabController: controller.playOnSiteTabController),
                  ],
                ),
              ),
              _rentOnSiteActiveIndicator(
                playstationType:
                    controller.currentOnSitePlaying["playstationType"],
                playtime: controller.currentOnSitePlaying["playtime"],
              )
            ],
          );
        }
        return const Center(
          child: RiveAnimation.asset('assets/rive/loading.riv'),
        );
      },
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
                child: InkWell(
                  onTap: () {
                    controller.onTapItem();
                  },
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

                                  return const SizedBox();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
}

class PreviousOrderOnSiteHistoryView
    extends GetWidget<PreviousOrderOnSiteHistoryController> {
  const PreviousOrderOnSiteHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchPreviousOnSiteHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.previousPlayOnSiteHistoryList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 64,
                          bottom: 100,
                        ),
                        shrinkWrap: true,
                        itemCount:
                            controller.previousPlayOnSiteHistoryList.length,
                        itemBuilder: (context, index) => HistoryCardItem(
                          productName:
                              controller.previousPlayOnSiteHistoryList[index]
                                  ["playstationType"],
                          transactionId: controller
                              .previousPlayOnSiteHistoryList[index]["rentalId"],
                          totalAmount:
                              controller.previousPlayOnSiteHistoryList[index]
                                  ["totalAmount"],
                          transactionDate:
                              controller.previousPlayOnSiteHistoryList[index]
                                  ["orderDate"],
                          gameCenter:
                              controller.previousPlayOnSiteHistoryList[index]
                                  ["gameCenter"],
                          onTap: () {
                            controller
                                .onTapPreviousOrderOnSiteHistoryItem(index);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/images/illustrations/no-transactions.svg",
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Belum Ada Transaksi",
                        style: TypographyTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                    ],
                  ),
                );
        }
        return const Center(
          child: RiveAnimation.asset('assets/rive/loading.riv'),
        );
      },
    );
  }
}

class FutureOrderOnSiteHistoryView
    extends GetWidget<FutureOrderOnSiteHistoryController> {
  const FutureOrderOnSiteHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: controller.fetchFutureOnSiteHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.futurePlayOnSiteHistoryList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 64,
                          bottom: 100,
                        ),
                        shrinkWrap: true,
                        itemCount:
                            controller.futurePlayOnSiteHistoryList.length,
                        itemBuilder: (context, index) => HistoryCardItem(
                          productName:
                              controller.futurePlayOnSiteHistoryList[index]
                                  ["playstationType"],
                          transactionId: controller
                              .futurePlayOnSiteHistoryList[index]["rentalId"],
                          totalAmount:
                              controller.futurePlayOnSiteHistoryList[index]
                                  ["totalAmount"],
                          transactionDate: controller
                              .futurePlayOnSiteHistoryList[index]["orderDate"],
                          gameCenter: controller
                              .futurePlayOnSiteHistoryList[index]["gameCenter"],
                          onTap: () {
                            controller
                                .onTapPreviousOrderOnSiteHistoryItem(index);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/images/illustrations/no-transactions.svg",
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Belum Ada Transaksi",
                        style: TypographyTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                    ],
                  ),
                );
        }
        return const Center(
          child: RiveAnimation.asset('assets/rive/loading.riv'),
        );
      },
    );
  }
}
