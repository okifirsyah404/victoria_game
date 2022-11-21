import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/image_source_dialog/image_source_dialog.dart';
import 'package:victoria_game/app/global/widgets/text_field/username_text_field/views/username_text_field_widget.dart';

import '../controllers/profile_settings_edit_user_profile_controller.dart';

class ProfileSettingsEditUserProfileView
    extends GetView<ProfileSettingsEditUserProfileController> {
  const ProfileSettingsEditUserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Ubah Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildImagePicker(
                    onTap: () {
                      print("Tapped");
                      // controller.openCamera();
                      Get.dialog(
                        ImageSourceDialog(
                          cameraAction: () {
                            controller.openCamera();
                            Get.back();
                          },
                          galeryAction: () {
                            controller.openGallery();
                            Get.back();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32),
                  UsernameTextField(
                    controller: controller.usernameController,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            color: ColorsTheme.neutralColor[900],
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorsTheme.neutralColor[900],
                backgroundColor: ColorsTheme.primaryColor,
              ),
              child: Text("Ubah Profile"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker({required VoidCallback onTap}) {
    return Obx(
      () => Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsTheme.primaryColor,
            width: 1,
          ),
          image: DecorationImage(
            image: controller.imageFile != null &&
                    controller.imageFile.value.path != ""
                ? Image.file(controller.imageFile.value).image
                : AssetImage(
                    "assets/images/drawable/profile/avatar-profile-100.jpg"),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: onTap,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsTheme.neutralColor[800],
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Ubah Foto",
                  style: TypographyTheme.bodyRegular
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
