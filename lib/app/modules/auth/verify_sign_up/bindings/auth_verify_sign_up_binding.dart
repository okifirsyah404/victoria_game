import 'package:get/get.dart';

import '../controllers/auth_verify_sign_up_controller.dart';

class AuthVerifySignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthVerifySignUpController>(
      () => AuthVerifySignUpController(),
    );
  }
}
