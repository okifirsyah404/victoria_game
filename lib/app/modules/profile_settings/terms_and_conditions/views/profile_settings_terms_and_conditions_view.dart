import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

import '../controllers/profile_settings_terms_and_conditions_controller.dart';

class ProfileSettingsTermsAndConditionsView
    extends GetView<ProfileSettingsTermsAndConditionsController> {
  const ProfileSettingsTermsAndConditionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Aplikasi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AKUN, SALDO, REFUND, PASSWORD DAN KEAMANAN",
              style: TypographyTheme.bodyMedium.copyWith(
                  color: ColorsTheme.primaryColor, fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.terms.length,
              itemBuilder: (context, index) =>
                  termItem(index + 1, controller.terms[index]),
            ),
            const SizedBox(height: 32),
            Text(
              "KETENTUAN LAIN",
              style: TypographyTheme.bodyMedium.copyWith(
                  color: ColorsTheme.primaryColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.otherTerms.length,
              itemBuilder: (context, index) =>
                  termItem(index + 1, controller.otherTerms[index]),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: Get.width,
              child: Center(
                child: Text(
                  "ENJOY YOUR GAME ENJOY YOUR LIFE",
                  style: TypographyTheme.bodyMedium.copyWith(
                      color: ColorsTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget termItem(int index, String term) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$index. "),
          Expanded(
            child: Text(
              term,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
