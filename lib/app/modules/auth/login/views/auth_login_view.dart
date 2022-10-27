import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/modules/global/themes/colors_theme.dart';
import 'package:victoria_game/app/modules/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/global/widgets/text_field/email_text_field/views/email_text_field_widget.dart';
import 'package:victoria_game/app/modules/global/widgets/text_field/password_text_field/views/password_text_field_widget.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Login",
                    style: TypographyTheme.titleLarge
                        .copyWith(color: ColorsTheme.primaryColor),
                  ),
                  const SizedBox(height: 8.0),
                  const Text("Silahkan Login Untuk Melanjutkan"),
                ],
              ),
              Column(
                children: [
                  EmailTextField(
                    textEditingController:
                        controller.emailTextEditingController,
                  ),
                  const SizedBox(height: 8.0),
                  PasswordTextField(
                      textEditingController:
                          controller.emailTextEditingController2),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Lupa Kata Sandi?",
                          style: TypographyTheme.bodyRegular.copyWith(
                            color: ColorsTheme.primaryColor,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 44.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Login"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun? "),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/register");
                    },
                    child: Text(
                      "Daftar Akun Victoria",
                      style: TypographyTheme.bodyRegular.copyWith(
                        color: ColorsTheme.primaryColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
