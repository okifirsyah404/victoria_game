import 'package:get/get.dart';

import '../controllers/auth_forgot_password_otp_input_controller.dart';

class AuthForgotPasswordOtpInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthForgotPasswordOtpInputController>(
      () => AuthForgotPasswordOtpInputController(),
    );
  }
}
