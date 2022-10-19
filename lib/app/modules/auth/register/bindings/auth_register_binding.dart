import 'package:get/get.dart';

import '../controllers/auth_register_controller.dart';

class AuthRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRegisterController>(
      () => AuthRegisterController(),
    );
  }
}
