import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/widgets/text_field/regular_text_field/views/regular_text_field_widget.dart';
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
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
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
                  const SizedBox(height: 8.0),
                  EmailTextField(
                      textEditingController: controller.emailController),
                  const SizedBox(height: 8.0),
                  RegularTextField(
                    controller: controller.phoneController,
                    label: "Nomor Handphone",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 8.0),
                  PasswordTextField(
                    textEditingController: controller.passwordController,
                    passwordCondition: "(Angka dan Huruf)",
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      controller.signUp();
                    },
                    child: const Text("Daftar"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun? "),
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
