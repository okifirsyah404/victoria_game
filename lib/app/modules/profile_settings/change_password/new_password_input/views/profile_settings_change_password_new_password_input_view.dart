import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/text_field/password_text_field/views/password_text_field_widget.dart';

import '../controllers/profile_settings_change_password_new_password_input_controller.dart';

class ProfileSettingsChangePasswordNewPasswordInputView
    extends GetView<ProfileSettingsChangePasswordNewPasswordInputController> {
  const ProfileSettingsChangePasswordNewPasswordInputView({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.onUserDataInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return onDataDone();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget onDataDone() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Harap Memasukkan Password Baru",
                style: TypographyTheme.bodyMedium.copyWith(
                  color: ColorsTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Gunakan password yang kuat dan mudah diingat olehmu ya! Seperti kenangan dengan mantan",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PasswordTextField(
                textEditingController: controller.passwordController,
                passwordCondition: "Baru",
              ),
              const SizedBox(height: 16),
              PasswordTextField(
                textEditingController: controller.rePasswordController,
                passwordPrefixText: "Ulangi ",
                passwordCondition: "Baru",
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  controller.onSubmitUpdatePassword();
                },
                child: const Text("Reset Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
