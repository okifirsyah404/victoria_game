import 'package:get/get.dart';

import '../controllers/profile_settings_change_password_otp_input_controller.dart';

class ProfileSettingsChangePasswordOtpInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsChangePasswordOtpInputController>(
      () => ProfileSettingsChangePasswordOtpInputController(),
    );
  }
}
