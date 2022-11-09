import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';

import '../controllers/main_page_rent_controller.dart';

class MainPageRentView extends GetView<MainPageRentController> {
  const MainPageRentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            child: Text(
              "Lorem ipsum dolor sit amet consectetur. Mauris nisl amet arcu feugiat leo.",
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          ...controller.listItem,
        ],
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
