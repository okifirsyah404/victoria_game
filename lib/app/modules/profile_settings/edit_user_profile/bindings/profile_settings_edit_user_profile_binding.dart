import 'package:get/get.dart';

import '../controllers/profile_settings_edit_user_profile_controller.dart';

class ProfileSettingsEditUserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsEditUserProfileController>(
      () => ProfileSettingsEditUserProfileController(),
    );
  }
}
