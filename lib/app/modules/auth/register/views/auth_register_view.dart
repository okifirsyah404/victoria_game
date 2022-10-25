import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/modules/global/themes/colors_theme.dart';
import 'package:victoria_game/app/modules/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/global/widgets/text_field/email_text_field/views/email_text_field_widget.dart';
import 'package:victoria_game/app/modules/global/widgets/text_field/password_text_field/views/password_text_field_widget.dart';
import 'package:victoria_game/app/modules/global/widgets/text_field/username_text_field/views/username_text_field_widget.dart';

import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Column(
            children: [
              UsernameTextField(controller: controller.textEditingController),
              SizedBox(height: 16.0),
              EmailTextField(
                  textEditingController: controller.textEditingController),
              SizedBox(height: 16.0),
              PasswordTextField(
                  textEditingController: controller.textEditingController),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {},
                child: Text("Daftar"),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun? "),
                  GestureDetector(
                    onTap: () {},
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
