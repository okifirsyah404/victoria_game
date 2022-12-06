import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/shimmer_widget.dart';

import '../controllers/profile_settings_change_password_otp_input_controller.dart';

class ProfileSettingsChangePasswordOtpInputView
    extends GetView<ProfileSettingsChangePasswordOtpInputController> {
  const ProfileSettingsChangePasswordOtpInputView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Verifikasi"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.onUserDataInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return onDataDone();
          }
          return onDataLoading();
        },
      ),
    );
  }

  Widget onDataDone() {
    return SafeArea(
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
    );
  }

  Widget onDataLoading() {
    return SafeArea(
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
            ShimmerWidget(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorsTheme.neutralColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Kami telah mengirim OTP (One-Time Password) Ke alamat email JohnDoe12345678",
                  style: TypographyTheme.bodyRegular,
                  textAlign: TextAlign.center,
                ),
              ),
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
              onPressed: () {},
              child: const Text("Verifikasi"),
            ),
          ],
        ),
      ),
    );
  }
}
