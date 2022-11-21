import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/core/services/network_service.dart';

import '../../global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import '../../routes/app_pages.dart';

class FirebaseAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  User? get currentUser => _currentUser;

  void createUserPasswordBased({
    required String emailAddress,
    required String password,
    required String username,
    required String route,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      User? user = credential.user;

      await user?.updateDisplayName(username).then((value) {
        Get.offAllNamed(route);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak password");
        Get.dialog(
          const SingleActionDialog(
            title: "Password Kamu Lemah",
            description:
                "Yah, Password kamu terlalu lemah. Coba pakai password yang kuat ya!",
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print("Email Sudah Terpakai");
        Get.dialog(
          const SingleActionDialog(
            title: "Email Sudah Terpakai",
            description:
                "Yah, Email yang kamu masukkan sudah pernah dipakai. Coba pakai email lain ya!",
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void signInUserPasswordBased({
    required String emailAddress,
    required String password,
    required String route,
  }) async {
    try {
      // await NetworkServices.signInUser(email: emailAddress, password: password);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        print(value.user);

        //   // Get.offAllNamed(route);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.dialog(
          const SingleActionDialog(
            title: "Email Kamu Nggak Ketemu",
            description:
                "Kami nggak menemukan emailmu, Coba cek lagi ya! Atau bisa daftar aja",
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.dialog(
          const SingleActionDialog(
            title: "Password Kamu Salah",
            description:
                "Yah, Password yang kamu masukan salah nih. Coba cek lagi ya!",
          ),
        );
      }
    }
  }

  void signOutUserPasswordBased() async {
    await FirebaseAuth.instance.signOut();
  }
}
