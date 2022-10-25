import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/modules/global/themes/colors_theme.dart';
import 'package:victoria_game/app/modules/global/themes/theme.dart';
import 'package:victoria_game/app/modules/global/themes/typography_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: MainTheme.darkTheme(context),
    );
  }
}
