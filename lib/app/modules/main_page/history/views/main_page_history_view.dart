import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/modules/main_page/history/views/order_on_site_history_view.dart';
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
        OrderOnSiteHistoryView(),
        const Text("Test 2"),
        const Text("Test 3"),
      ],
    );
  }
}

class HistoryCardItem extends GetWidget {
  const HistoryCardItem(
      {super.key,
      required this.gameCenter,
      required this.productName,
      required this.totalAmount,
      required this.transactionId,
      required this.transactionDate,
      this.onTap});

  final String productName;
  final String transactionId;
  final String gameCenter;
  final int totalAmount;
  final DateTime transactionDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
