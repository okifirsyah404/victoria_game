import 'package:get/get.dart';

import '../controllers/auth_sign_in_controller.dart';

class AuthSignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthSignInController>(
      () => AuthSignInController(),
    );
  }
}
