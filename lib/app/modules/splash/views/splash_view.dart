import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/controllers/app_controller.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);

  final appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsTheme.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/images/logo/brand-logo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${controller.appName}",
                      style: TextStyle(
                        fontFamily: "NotoSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorsTheme.neutralColor[900],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "v 1.0.0",
                style: TextStyle(
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: ColorsTheme.neutralColor[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
