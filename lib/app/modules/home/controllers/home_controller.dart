import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../../../core/services/firebase_auth_services.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  void signOut() {
    firebaseAuthServices.signOutUserPasswordBased();
    Get.offAllNamed(Routes.AUTH_SIGN_IN);
  }

  final count = 0.obs;
  @override
  void onInit() {
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

  void increment() => count.value++;
}
