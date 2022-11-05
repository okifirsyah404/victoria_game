import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../../../../global/themes/colors_theme.dart';
import '../../../../global/themes/typography_theme.dart';
import '../../../../global/widgets/text_field/email_text_field/views/email_text_field_widget.dart';
import '../../../../global/widgets/text_field/password_text_field/views/password_text_field_widget.dart';
import '../controllers/auth_sign_in_controller.dart';

class AuthSignInView extends GetView<AuthSignInController> {
  const AuthSignInView({Key? key}) : super(key: key);
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
                    textEditingController: controller.emailController,
                  ),
                  const SizedBox(height: 8.0),
                  PasswordTextField(
                      textEditingController: controller.passwordController),
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
                    onPressed: () {
                      controller.signIn();
                      // if (controller.emailController.text.isEmpty &&
                      //     controller.passwordController.text.isEmpty) {
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) => SingleActionDialog(
                      //       title: "Email Sudah Terpakai",
                      //       description:
                      //           "Yah, Email yang kamu masukkan sudah pernah dipakai. Coba pakai email lain ya!",
                      //     ),
                      //   );
                      // }
                    },
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
                      Get.offNamed(Routes.AUTH_SIGN_UP);
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
