import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_forgot_password_forgot_password_email_controller.dart';

class AuthForgotPasswordForgotPasswordEmailView
    extends GetView<AuthForgotPasswordForgotPasswordEmailController> {
  const AuthForgotPasswordForgotPasswordEmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthForgotPasswordForgotPasswordEmailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AuthForgotPasswordForgotPasswordEmailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
