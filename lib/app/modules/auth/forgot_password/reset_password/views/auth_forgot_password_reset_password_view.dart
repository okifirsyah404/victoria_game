import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_forgot_password_reset_password_controller.dart';

class AuthForgotPasswordResetPasswordView
    extends GetView<AuthForgotPasswordResetPasswordController> {
  const AuthForgotPasswordResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthForgotPasswordResetPasswordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AuthForgotPasswordResetPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
