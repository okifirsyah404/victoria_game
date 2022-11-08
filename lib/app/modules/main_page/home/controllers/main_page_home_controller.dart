import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/services/firebase_auth_services.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

import '../../../../routes/app_pages.dart';

class MainPageHomeController extends GetxController {
  //TODO: Implement MainPageHomeController

  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  void signOut() {
    firebaseAuthServices.signOutUserPasswordBased();
    Get.offAllNamed(Routes.AUTH_SIGN_IN);
  }

  var listItem = List.generate(
      7,
      (index) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorsTheme.neutralColor[600],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Tempat $index",
                      style: TypographyTheme.titleSmall.copyWith(
                        color: ColorsTheme.primaryColor,
                      ),
                    ),
                    Text("Alamat Tempat"),
                  ],
                ),
              ),
            ),
          ));

  @override
  void onInit() {
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
