import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../controllers/auth_forgot_password_otp_input_controller.dart';

class AuthForgotPasswordOtpInputView
    extends GetView<AuthForgotPasswordOtpInputController> {
  const AuthForgotPasswordOtpInputView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Verifikasi"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verifikasi Email Kamu",
                style: TypographyTheme.titleMedium
                    .copyWith(color: ColorsTheme.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                "Kami telah mengirim OTP (One-Time Password) Ke alamat email ${controller.userMail}",
                style: TypographyTheme.bodyRegular,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 240,
                child: TextField(
                  controller: controller.otpController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: TypographyTheme.bodyMedium.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 6.0,
                  ),
                  cursorColor: ColorsTheme.neutralColor[900],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorsTheme.neutralColor[50],
                    counterText: "",
                    counterStyle: const TextStyle(height: double.minPositive),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tidak menerima kode OTP?",
                    style: TypographyTheme.bodyRegular,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => controller.onResendOtp(),
                    child: Text(
                      "Kirim Ulang",
                      style: TypographyTheme.bodyRegular.copyWith(
                        color: ColorsTheme.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: () {
                  controller.onSubmitOtp();
                },
                child: const Text("Verifikasi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
