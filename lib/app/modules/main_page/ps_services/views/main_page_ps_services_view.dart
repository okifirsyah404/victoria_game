import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

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
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                    "assets/images/illustrations/play-service.svg"),
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
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit",
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.onPressedService();
                },
                child: Text("Servis Sekarang"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
