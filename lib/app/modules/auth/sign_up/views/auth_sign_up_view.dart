import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../../../../global/themes/colors_theme.dart';
import '../../../../global/themes/typography_theme.dart';
import '../../../../global/widgets/text_field/email_text_field/views/email_text_field_widget.dart';
import '../../../../global/widgets/text_field/password_text_field/views/password_text_field_widget.dart';
import '../../../../global/widgets/text_field/username_text_field/views/username_text_field_widget.dart';
import '../controllers/auth_sign_up_controller.dart';

class AuthSignUpView extends GetView<AuthSignUpController> {
  const AuthSignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Register",
                    style: TypographyTheme.titleLarge
                        .copyWith(color: ColorsTheme.primaryColor),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Silahkan Register Victoria Game Untuk Melanjutkan",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  UsernameTextField(controller: controller.usernameController),
                  SizedBox(height: 8.0),
                  EmailTextField(
                      textEditingController: controller.emailController),
                  SizedBox(height: 8.0),
                  PasswordTextField(
                      textEditingController: controller.passwordController),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Daftar"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun? "),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(Routes.AUTH_SIGN_IN);
                    },
                    child: Text(
                      "Silahkan Login",
                      style: TypographyTheme.bodyRegular.copyWith(
                        color: ColorsTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
