import 'package:get/get.dart';

import '../controllers/profile_settings_terms_and_conditions_controller.dart';

class ProfileSettingsTermsAndConditionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsTermsAndConditionsController>(
      () => ProfileSettingsTermsAndConditionsController(),
    );
  }
}
