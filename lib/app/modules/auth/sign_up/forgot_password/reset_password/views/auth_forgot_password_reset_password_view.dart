import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/text_field/password_text_field/views/password_text_field_widget.dart';

import '../controllers/auth_forgot_password_reset_password_controller.dart';

class AuthForgotPasswordResetPasswordView
    extends GetView<AuthForgotPasswordResetPasswordController> {
  const AuthForgotPasswordResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: SafeArea(
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
                Text(
                  "Gunakan password yang kuat dan mudah diingat olehmu ya",
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
                  child: Text("Reset Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
