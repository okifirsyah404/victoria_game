import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/main_page/history/controllers/order_at_home_history_controller.dart';
import 'package:victoria_game/utils/int_extensions.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class OrderAtHomeHistoryView extends GetWidget<OrderAtHomeHistoryController> {
  const OrderAtHomeHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
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
                          PendingOrderAtHomeHistoryView(),
                          ActiveOrderAtHomeHistoryView(),
                          FinishedOrderAtHomeHistoryView(),
                          CanceledOrderAtHomeHistoryView(),
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

class AtHomeHistoryCardItem extends GetWidget {
  const AtHomeHistoryCardItem(
      {super.key,
      required this.gameCenter,
      required this.productName,
      required this.status,
      required this.totalAmount,
      required this.transactionId,
      required this.transactionDate,
      this.onTap});

  final String productName;
  final String transactionId;
  final String gameCenter;
  final String status;
  final int totalAmount;
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
                  style: TypographyTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  gameCenter.toTitleCase(),
                  style: TypographyTheme.bodyRegular.copyWith(),
                ),
                const SizedBox(height: 4),
                Text(
                  status.toTitleCase(),
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
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
}

class PendingOrderAtHomeHistoryView
    extends GetWidget<PendingOrderAtHomeHistoryController> {
  const PendingOrderAtHomeHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchPendingOrderAtHomeHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.pendingOrderAtHomeHistoryList.isNotEmpty
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
                            controller.pendingOrderAtHomeHistoryList.length,
                        itemBuilder: (context, index) => AtHomeHistoryCardItem(
                          gameCenter: controller
                              .pendingOrderAtHomeHistoryList[index].gameCenter!,
                          productName: controller
                              .pendingOrderAtHomeHistoryList[index]
                              .playstationType!
                              .toTitleCase(),
                          status: "Menunggu Konfirmasi",
                          totalAmount: controller
                              .pendingOrderAtHomeHistoryList[index]
                              .totalAmount!,
                          transactionId: controller
                              .pendingOrderAtHomeHistoryList[index].orderId!,
                          transactionDate: controller
                              .pendingOrderAtHomeHistoryList[index].orderTime!,
                          onTap: () {
                            controller
                                .onTapPendingOrderAtHomeHistoryItem(index);
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

class ActiveOrderAtHomeHistoryView
    extends GetWidget<ActiveOrderAtHomeHistoryController> {
  const ActiveOrderAtHomeHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchActiveOrderAtHomeHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.activeOrderAtHomeHistoryList.isNotEmpty
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
                            controller.activeOrderAtHomeHistoryList.length,
                        itemBuilder: (context, index) => AtHomeHistoryCardItem(
                          gameCenter: controller
                              .activeOrderAtHomeHistoryList[index].gameCenter!,
                          productName: controller
                              .activeOrderAtHomeHistoryList[index]
                              .playstationType!
                              .toTitleCase(),
                          status: "Aktif",
                          totalAmount: controller
                              .activeOrderAtHomeHistoryList[index].totalAmount!,
                          transactionId: controller
                              .activeOrderAtHomeHistoryList[index].orderId!,
                          transactionDate: controller
                              .activeOrderAtHomeHistoryList[index].orderTime!,
                          onTap: () {
                            controller.onTapActiveOrderAtHomeHistoryItem(index);
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

class FinishedOrderAtHomeHistoryView
    extends GetWidget<FinishedOrderAtHomeHistoryController> {
  const FinishedOrderAtHomeHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchFinishedOrderAtHomeHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.finishedOrderAtHomeHistoryList.isNotEmpty
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
                            controller.finishedOrderAtHomeHistoryList.length,
                        itemBuilder: (context, index) => AtHomeHistoryCardItem(
                          gameCenter: controller
                              .finishedOrderAtHomeHistoryList[index]
                              .gameCenter!,
                          productName: controller
                              .finishedOrderAtHomeHistoryList[index]
                              .playstationType!
                              .toTitleCase(),
                          status: "Selesai",
                          totalAmount: controller
                              .finishedOrderAtHomeHistoryList[index]
                              .totalAmount!,
                          transactionId: controller
                              .finishedOrderAtHomeHistoryList[index].orderId!,
                          transactionDate: controller
                              .finishedOrderAtHomeHistoryList[index].orderTime!,
                          onTap: () {
                            controller
                                .onTapFinishedOrderAtHomeHistoryItem(index);
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

class CanceledOrderAtHomeHistoryView
    extends GetWidget<CanceledOrderAtHomeHistoryController> {
  const CanceledOrderAtHomeHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchCanceledOrderAtHomeHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controller.canceledOrderAtHomeHistoryList.isNotEmpty
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
                            controller.canceledOrderAtHomeHistoryList.length,
                        itemBuilder: (context, index) => AtHomeHistoryCardItem(
                          gameCenter: controller
                              .canceledOrderAtHomeHistoryList[index]
                              .gameCenter!,
                          productName: controller
                              .canceledOrderAtHomeHistoryList[index]
                              .playstationType!
                              .toTitleCase(),
                          status: "Dibatalkan",
                          totalAmount: controller
                              .canceledOrderAtHomeHistoryList[index]
                              .totalAmount!,
                          transactionId: controller
                              .canceledOrderAtHomeHistoryList[index].orderId!,
                          transactionDate: controller
                              .canceledOrderAtHomeHistoryList[index].orderTime!,
                          onTap: () {
                            controller
                                .onTapCanceledOrderAtHomeHistoryItem(index);
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
