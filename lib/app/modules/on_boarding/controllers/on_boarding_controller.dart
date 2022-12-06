import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

import '../../../global/themes/colors_theme.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  late SecureStorage secureStorage;

  RxInt pageIndex = 0.obs;

  final List onBoardingImage = [
    "assets/images/illustrations/play-onsite.svg",
    "assets/images/illustrations/play-at-home.svg",
    "assets/images/illustrations/play.svg"
  ];

  final List onBoardingTitle = [
    "Rental Di Tempat",
    "Rental Di Rumah",
    "Mainkan Sepuasnya!"
  ];

  final List onBoardingDescription = [
    "Pesan dari rumah, main di lokasi gak pakai tunggu yang lain selesai",
    "Tinggal pesan, kemudian take away playstation atau diantarkan",
    "Mainkan game Playstation sepuasnya!",
  ];

  RxString buttonLabel = "Lanjutkan".obs;

  void onChangePage(int index) {
    pageIndex.value = index;

    if (index >= onBoardingTitle.length - 1) {
      buttonLabel.value = "Mainkan";
    } else {
      buttonLabel.value = "Lanjutkan";
    }
  }

  void nextPage() {
    if (pageIndex.value < onBoardingTitle.length - 1) {
      pageController.nextPage(
          duration: Duration(
            milliseconds: 300,
          ),
          curve: Curves.ease);
    } else {
      secureStorage.writeDataToStorage(key: 'intro', value: "true");
      Get.offAllNamed(Routes.AUTH_SIGN_IN);
    }
  }

  Widget pageIndicatorNode(bool isCurrentIndex) {
    return AnimatedContainer(
      height: 8,
      width: 8,
      duration: Duration(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isCurrentIndex
            ? ColorsTheme.primaryColor
            : ColorsTheme.neutralColor[50],
      ),
    );
  }

  List<Widget> pageIndicator() {
    return List.generate(
      onBoardingTitle.length,
      (index) => AnimatedContainer(
        height: 8,
        width: 8,
        duration: Duration(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: index == pageIndex.value
              ? ColorsTheme.primaryColor
              : ColorsTheme.neutralColor[50],
        ),
      ),
    );
  }

  @override
  void onInit() {
    secureStorage = SecureStorage.instance;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
