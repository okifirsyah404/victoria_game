import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';

class FirebaseAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  User? get currentUser => _currentUser;

  void createUserPasswordBased(
      {required String emailAddress,
      password,
      required BuildContext context}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) => const SingleActionDialog(
            title: "Password kamu lemah",
            description:
                "Yah, Password kamu terlalulemah. Coba pakai password yang kuat ya!",
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => const SingleActionDialog(
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

  void signInUserPasswordBased(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
