import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_forgot_password_email_input_controller.dart';

class AuthForgotPasswordEmailInputView
    extends GetView<AuthForgotPasswordEmailInputController> {
  const AuthForgotPasswordEmailInputView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthForgotPasswordEmailInputView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AuthForgotPasswordEmailInputView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
