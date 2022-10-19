import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthRegisterView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AuthRegisterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
