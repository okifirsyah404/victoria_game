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
import 'package:victoria_game/app/modules/main_page/history/controllers/playstation_service_history_controller.dart';
import 'package:victoria_game/app/modules/main_page/history/views/main_page_history_view.dart';
import 'package:victoria_game/utils/int_extensions.dart';
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
                          Text("Pending"),
                          Text("Progress"),
                          Text("Selesai"),
                          Text("Batal"),
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
