import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/playstation_service_history_controller.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class PlaystationServiceHistoryView
    extends GetWidget<PlaystationServiceHistoryController> {
  const PlaystationServiceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    TabBarView(
                        controller:
                            controller.playstationServiceHistoryTabController,
                        children: const [
                          PendingPlaystationServiceHistoryView(),
                          ProgressPlaystationServiceHistoryView(),
                          FinishedPlaystationServiceHistoryView(),
                          CanceledPlaystationServiceHistoryView(),
                        ]),
                    _secondaryTabBarBuilder(
                        tabController:
                            controller.playstationServiceHistoryTabController),
                  ],
                ),
              ),
            ],
          );
        }
        return const Center(
          child: RiveAnimation.asset('assets/rive/loading.riv'),
        );
      },
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

class ServiceHistoryCardItem extends GetWidget {
  const ServiceHistoryCardItem(
      {super.key,
      required this.productName,
      required this.transactionId,
      required this.transactionDate,
      required this.gameCenter,
      required this.status,
      required this.problem,
      this.onTap});

  final String productName;
  final String transactionId;
  final String gameCenter;
  final String problem;
  final String status;
  final DateTime transactionDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 4),
                Text(
                  transactionId,
                  style: TypographyTheme.bodyRegular,
                ),
                const SizedBox(height: 4),
                Text(
                  gameCenter.toTitleCase(),
                  style: TypographyTheme.bodyRegular.copyWith(),
                ),
                const SizedBox(height: 4),
                Text(
                  problem.toTitleCase(),
                  style: TypographyTheme.bodyRegular.copyWith(),
                ),
                const SizedBox(height: 8),
                Divider(
                  color: ColorsTheme.neutralColor,
                  height: 8,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      status,
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
}

class PendingPlaystationServiceHistoryView
    extends GetWidget<PendingPlaystationServiceHistoryController> {
  const PendingPlaystationServiceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchPendingPlaystationServiceHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.pendingPlaystationServiceHistoryList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 64,
                          bottom: 100,
                        ),
                        shrinkWrap: true,
                        itemCount: controller
                            .pendingPlaystationServiceHistoryList.length,
                        itemBuilder: (context, index) => ServiceHistoryCardItem(
                          productName: controller
                                  .pendingPlaystationServiceHistoryList[index]
                              ["productName"],
                          transactionId: controller
                                  .pendingPlaystationServiceHistoryList[index]
                              ["serviceId"],
                          transactionDate: controller
                                  .pendingPlaystationServiceHistoryList[index]
                              ["submitTime"],
                          gameCenter: controller
                                  .pendingPlaystationServiceHistoryList[index]
                              ["gameCenter"],
                          status: "Menuggu Konfirmasi",
                          problem: controller
                                  .pendingPlaystationServiceHistoryList[index]
                              ["problem"],
                          onTap: () {
                            controller
                                .onTapPendingPlaystationHistoryHistoryItem(
                              index,
                            );
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
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/images/illustrations/no-transactions.svg",
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Belum Ada Servis Pending",
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

class ProgressPlaystationServiceHistoryView
    extends GetWidget<ProgressPlaystationServiceHistoryController> {
  const ProgressPlaystationServiceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchProgressPlaystationServiceHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.progressPlaystationServiceHistoryList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 64,
                          bottom: 100,
                        ),
                        shrinkWrap: true,
                        itemCount: controller
                            .progressPlaystationServiceHistoryList.length,
                        itemBuilder: (context, index) => ServiceHistoryCardItem(
                          productName: controller
                                  .progressPlaystationServiceHistoryList[index]
                              ["productName"],
                          transactionId: controller
                                  .progressPlaystationServiceHistoryList[index]
                              ["serviceId"],
                          transactionDate: controller
                                  .progressPlaystationServiceHistoryList[index]
                              ["submitTime"],
                          gameCenter: controller
                                  .progressPlaystationServiceHistoryList[index]
                              ["gameCenter"],
                          status: "Sedang Diproses",
                          problem: controller
                                  .progressPlaystationServiceHistoryList[index]
                              ["problem"],
                          onTap: () {
                            controller
                                .onTapProgressPlaystationHistoryHistoryItem(
                                    index);
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
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/images/illustrations/no-transactions.svg",
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Belum Ada Servis Diproses",
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

class FinishedPlaystationServiceHistoryView
    extends GetWidget<FinishedPlaystationServiceHistoryController> {
  const FinishedPlaystationServiceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchFinishedPlaystationServiceHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.finishedPlaystationServiceHistoryList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 64,
                          bottom: 100,
                        ),
                        shrinkWrap: true,
                        itemCount: controller
                            .finishedPlaystationServiceHistoryList.length,
                        itemBuilder: (context, index) => ServiceHistoryCardItem(
                          productName: controller
                                  .finishedPlaystationServiceHistoryList[index]
                              ["productName"],
                          transactionId: controller
                                  .finishedPlaystationServiceHistoryList[index]
                              ["serviceId"],
                          transactionDate: controller
                                  .finishedPlaystationServiceHistoryList[index]
                              ["submitTime"],
                          gameCenter: controller
                                  .finishedPlaystationServiceHistoryList[index]
                              ["gameCenter"],
                          status: "Selesai",
                          problem: controller
                                  .finishedPlaystationServiceHistoryList[index]
                              ["problem"],
                          onTap: () {
                            controller
                                .onTapFinishedPlaystationHistoryHistoryItem(
                                    index);
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
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/images/illustrations/no-transactions.svg",
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Belum Ada Servis Selesai",
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

class CanceledPlaystationServiceHistoryView
    extends GetWidget<CanceledPlaystationServiceHistoryController> {
  const CanceledPlaystationServiceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchCanceledPlaystationServiceHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.canceledPlaystationServiceHistoryList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 64,
                          bottom: 100,
                        ),
                        shrinkWrap: true,
                        itemCount: controller
                            .canceledPlaystationServiceHistoryList.length,
                        itemBuilder: (context, index) => ServiceHistoryCardItem(
                          productName: controller
                                  .canceledPlaystationServiceHistoryList[index]
                              ["productName"],
                          transactionId: controller
                                  .canceledPlaystationServiceHistoryList[index]
                              ["serviceId"],
                          transactionDate: controller
                                  .canceledPlaystationServiceHistoryList[index]
                              ["submitTime"],
                          gameCenter: controller
                                  .canceledPlaystationServiceHistoryList[index]
                              ["gameCenter"],
                          status: "Dibatalkan",
                          problem: controller
                                  .canceledPlaystationServiceHistoryList[index]
                              ["problem"],
                          onTap: () {
                            controller
                                .onTapCanceledPlaystationHistoryHistoryItem(
                                    index);
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
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/images/illustrations/no-transactions.svg",
                          color: ColorsTheme.neutralColor[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Belum Ada Servis Dibatalkan",
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
