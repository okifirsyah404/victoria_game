import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    // padding: EdgeInsets.only(bottom: 105.0),
                    child: AspectRatio(
                      aspectRatio: 328 / 372,
                      child: SizedBox(
                        height: 150,
                        child: PageView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          itemCount: controller.onBoardingTitle.length,
                          onPageChanged: (value) {
                            controller.onChangePage(value);
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  // child: SvgPicture.asset(
                                  //     controller.onBoardingImage[index]),
                                  child: RiveAnimation.asset(
                                    "assets/rive/play-service.riv",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 88),
                                Text(
                                  controller.onBoardingTitle[index],
                                  style: TypographyTheme.titleMedium.copyWith(
                                    color: ColorsTheme.primaryColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0, top: 16.0),
                                  child: Text(
                                    controller.onBoardingDescription[index],
                                    textAlign: TextAlign.center,
                                    style: TypographyTheme.bodyRegular,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.pageIndicator(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.nextPage();
                  },
                  child: Text(controller.buttonLabel.value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
