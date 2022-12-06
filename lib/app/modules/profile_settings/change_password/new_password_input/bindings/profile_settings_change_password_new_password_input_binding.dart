import 'package:get/get.dart';

import '../controllers/profile_settings_change_password_new_password_input_controller.dart';

class ProfileSettingsChangePasswordNewPasswordInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsChangePasswordNewPasswordInputController>(
      () => ProfileSettingsChangePasswordNewPasswordInputController(),
    );
  }
}
