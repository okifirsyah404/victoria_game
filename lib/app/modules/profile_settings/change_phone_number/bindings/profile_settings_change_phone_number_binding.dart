import 'package:get/get.dart';

import '../controllers/profile_settings_change_phone_number_controller.dart';

class ProfileSettingsChangePhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsChangePhoneNumberController>(
      () => ProfileSettingsChangePhoneNumberController(),
    );
  }
}
