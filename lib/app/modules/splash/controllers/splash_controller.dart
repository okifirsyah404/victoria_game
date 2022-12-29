import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SplashController extends GetxController {
  late Connectivity connectivity;
  late SecureStorage secureStorage;
  late UserRepository userRepository;

  bool hasConnection = false;

  final String appName = "Victoria Game";

  String authToken = "";
  String introduction = "";

  Future<void> preCachedSvgImages() async {
    Future.wait(
      [
        precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
              'assets/images/illustrations/play-onsite.svg'),
          null,
        ),
        precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
              'assets/images/illustrations/play-at-home.svg'),
          null,
        ),
        precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
              'assets/images/illustrations/play.svg'),
          null,
        ),
        precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
              'assets/images/illustrations/play-service.svg'),
          null,
        ),
      ],
    );
  }

  onInitSplashScreen() async {
    var duration = const Duration(seconds: 5);

    var connection = await checkInternetConnection();

    return Timer(duration, () {
      if (connection) {
        if (introduction.isNotEmpty) {
          if (authToken.isEmpty) {
            Get.offNamed(Routes.AUTH_SIGN_IN);
          } else {
            Get.offNamed(Routes.MAIN_PAGE_HOME);
          }
        } else {
          Get.offNamed(Routes.ON_BOARDING);
        }
      } else {
        Get.dialog(SingleActionDialog(
          title: "Network Error",
          description: "Tidak ada koneksi Internet",
          buttonFunction: () async {
            await Get.deleteAll(force: true);
            Phoenix.rebirth(Get.context!);
            Get.reset();
          },
        ));
      }
    });
  }

  Future<bool> checkInternetConnection() async {
    bool previousConnection = hasConnection;
    try {
      final result =
          await InternetAddress.lookup('fda5-125-166-118-213.ap.ngrok.io');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      previousConnection = hasConnection;
    }

    return hasConnection;
  }

  Future<void> getSharedPreferences() async {
    authToken = await secureStorage.readDataFromStrorage('token') ?? "";
    introduction = await secureStorage.readDataFromStrorage('intro') ?? "";
  }

  @override
  void onInit() {
    connectivity = Connectivity();
    secureStorage = SecureStorage.instance;
    userRepository = UserRepository.instance;
    getSharedPreferences();
    onInitSplashScreen();
    preCachedSvgImages();
    super.onInit();
  }
}
