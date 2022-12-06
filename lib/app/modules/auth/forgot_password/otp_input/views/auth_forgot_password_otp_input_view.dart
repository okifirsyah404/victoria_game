import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_forgot_password_otp_input_controller.dart';

class AuthForgotPasswordOtpInputView
    extends GetView<AuthForgotPasswordOtpInputController> {
  const AuthForgotPasswordOtpInputView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthForgotPasswordOtpInputView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AuthForgotPasswordOtpInputView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
