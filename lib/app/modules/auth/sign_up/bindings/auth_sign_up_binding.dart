import 'package:get/get.dart';

import '../controllers/auth_sign_up_controller.dart';

class AuthSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthSignUpController>(
      () => AuthSignUpController(),
    );
  }
}
