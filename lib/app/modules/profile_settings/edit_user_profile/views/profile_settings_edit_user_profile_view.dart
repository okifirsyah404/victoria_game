import 'dart:io';

import 'package:flutter/foundation.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Ubah Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildImagePicker(
                          onTap: () {
                            print("Tapped");
                            Get.dialog(
                              ImageSourceDialog(
                                cameraAction: () {
                                  controller.openCamera();
                                },
                                galeryAction: () {
                                  controller.openGallery();
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
                    onPressed: () {
                      controller.onSubmitEdit();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorsTheme.neutralColor[900],
                      backgroundColor: ColorsTheme.primaryColor,
                    ),
                    child: Text("Ubah Profile"),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
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
            image: controller.imageFile.value.path != ""
                ? Image.file(controller.imageFile.value).image
                // : NetworkImage(
                //     "https://e066-125-166-116-58.ap.ngrok.io/api/user/image",
                //     headers: {
                //         "Authorization": controller.authAccessToken,
                //       }),
                : MemoryImage(Uint8List.fromList(controller.imageByte)),
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
