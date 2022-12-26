import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/text_field/password_text_field/views/password_text_field_widget.dart';

import '../controllers/service_verify_controller.dart';

class ServiceVerifyView extends GetView<ServiceVerifyController> {
  const ServiceVerifyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Verifikasi Order'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                            height: 328,
                            width: 328,
                            child: RiveAnimation.asset(
                                "assets/rive/order-verify.riv")),
                        Text(
                          "Harap verifikasi bahwa transaksi ini dibuat olehmu ya!",
                          style: TypographyTheme.bodyMedium
                              .copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        PasswordTextField(
                            textEditingController:
                                controller.passwordController),
                      ],
                    ),
                    const SizedBox(height: 32),
                    OutlinedButton(
                      onPressed: () {
                        controller.submitVerifyOrder();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorsTheme.primaryColor,
                      ),
                      child: const Text("Verifikasi Order"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
