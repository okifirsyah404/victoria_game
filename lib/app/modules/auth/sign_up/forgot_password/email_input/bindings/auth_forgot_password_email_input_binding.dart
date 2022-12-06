import 'package:get/get.dart';

import '../controllers/auth_forgot_password_email_input_controller.dart';

class AuthForgotPasswordEmailInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthForgotPasswordEmailInputController>(
      () => AuthForgotPasswordEmailInputController(),
    );
  }
}
