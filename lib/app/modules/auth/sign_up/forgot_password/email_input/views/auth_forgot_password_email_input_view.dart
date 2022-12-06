import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/widgets/text_field/email_text_field/views/email_text_field_widget.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../controllers/auth_forgot_password_email_input_controller.dart';

class AuthForgotPasswordEmailInputView
    extends GetView<AuthForgotPasswordEmailInputController> {
  const AuthForgotPasswordEmailInputView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Lupa Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Masukkan email yang terhubung dengan akun kamu. Kemudian kami akan mengirim OTP ke email yang kamu input",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            EmailTextField(textEditingController: controller.emailController),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                controller.onSubmitEmail();
                // Get.toNamed(Routes.AUTH_FORGOT_PASSWORD_OTP_INPUT);
              },
              child: const Text("Kirim OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
