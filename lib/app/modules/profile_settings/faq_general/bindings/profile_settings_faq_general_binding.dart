import 'package:get/get.dart';

import '../controllers/profile_settings_faq_general_controller.dart';

class ProfileSettingsFaqGeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsFaqGeneralController>(
      () => ProfileSettingsFaqGeneralController(),
    );
  }
}
