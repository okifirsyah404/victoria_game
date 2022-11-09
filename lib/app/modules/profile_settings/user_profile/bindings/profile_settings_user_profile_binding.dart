import 'package:get/get.dart';

import '../controllers/profile_settings_user_profile_controller.dart';

class ProfileSettingsUserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsUserProfileController>(
      () => ProfileSettingsUserProfileController(),
    );
  }
}
