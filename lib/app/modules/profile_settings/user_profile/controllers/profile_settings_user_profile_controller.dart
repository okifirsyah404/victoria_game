import 'package:get/get.dart';

import '../../../../core/services/firebase_auth_services.dart';
import '../../../../routes/app_pages.dart';

class ProfileSettingsUserProfileController extends GetxController {
  //TODO: Implement ProfileSettingsUserProfileController

  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  void signOut() {
    firebaseAuthServices.signOutUserPasswordBased();
    Get.offAllNamed(Routes.AUTH_SIGN_IN);
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
