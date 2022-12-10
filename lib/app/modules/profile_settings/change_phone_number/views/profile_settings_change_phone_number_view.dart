import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/widgets/text_field/regular_text_field/views/regular_text_field_widget.dart';

import '../controllers/profile_settings_change_phone_number_controller.dart';

class ProfileSettingsChangePhoneNumberView
    extends GetView<ProfileSettingsChangePhoneNumberController> {
  const ProfileSettingsChangePhoneNumberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Nomor Handphone'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchUserPhoneNumber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return onDataDone();
          }
          return onDataLoading();
        },
      ),
    );
  }

  Widget onDataLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget onDataDone() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RegularTextField(
              controller: controller.phoneController,
              label: "Nomor Handphone",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: () {
                controller.onSubmitChangeNumber();
              },
              child: Text(
                "Ubah Nomor Handphone",
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: ColorsTheme.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
