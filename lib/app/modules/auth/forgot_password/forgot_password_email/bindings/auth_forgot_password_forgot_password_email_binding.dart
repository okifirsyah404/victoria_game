import 'package:get/get.dart';

import '../controllers/auth_forgot_password_forgot_password_email_controller.dart';

class AuthForgotPasswordForgotPasswordEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthForgotPasswordForgotPasswordEmailController>(
      () => AuthForgotPasswordForgotPasswordEmailController(),
    );
  }
}
