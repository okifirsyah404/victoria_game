import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../../global/themes/colors_theme.dart';
import '../../../../global/themes/typography_theme.dart';
import '../../../../global/widgets/navigation/bottom_navigation/main_bottom_navigation.dart';
import '../controllers/main_page_ps_services_controller.dart';

class MainPagePsServicesView extends GetView<MainPagePsServicesController> {
  const MainPagePsServicesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Servis Playstation',
          style: TypographyTheme.titleRegular.copyWith(
            color: ColorsTheme.primaryColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 200,
                width: 200,
                child: const RiveAnimation.asset(
                  "assets/rive/play-service.riv",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 6.0),
                child: Text(
                  "Playstation kamu rusak? Servis Sekarang!",
                  style: TypographyTheme.titleSmall.copyWith(
                    color: ColorsTheme.primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TypographyTheme.bodyRegular,
                    children: [
                      const TextSpan(
                          text:
                              "Servis berbagai macam kerusakan Playstation kamu! Hanya ada di "),
                      TextSpan(
                        text: "Tolonto Game Bojonegoro",
                        style: TypographyTheme.bodyRegular.copyWith(
                            color: ColorsTheme.primaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                // child: Text(
                //   "Kami menyediakan berbagai macam servis untuk memperbaiki kerusakan Playstation kamu! Hanya ada di Tolonto Game Bojonegoro",
                //   textAlign: TextAlign.center,
                // ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.onPressedService();
                },
                child: const Text("Servis Sekarang"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
