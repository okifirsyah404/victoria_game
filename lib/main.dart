import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/modules/themes/colors_theme.dart';
import 'package:victoria_game/app/modules/themes/typography_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.dark().copyWith(
        textTheme: TypographyTheme.mainTextTheme.copyWith(),
      ),
    ),
  );
}
