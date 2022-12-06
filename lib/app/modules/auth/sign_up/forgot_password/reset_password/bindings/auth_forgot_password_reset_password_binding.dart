import 'package:get/get.dart';

import '../controllers/auth_forgot_password_reset_password_controller.dart';

class AuthForgotPasswordResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthForgotPasswordResetPasswordController>(
      () => AuthForgotPasswordResetPasswordController(),
    );
  }
}
