import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/services/firebase_auth_services.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  // Stream<User?> get authStateChange =>
  //     firebaseAuthServices.firebaseAuth.authStateChanges();

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
}
