import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsEditUserProfileController extends GetxController {
  //TODO: Implement ProfileSettingsEditUserProfileController

  var imagePicker = ImagePicker();

  Rx<File> imageFile = File("").obs;

  late TextEditingController usernameController;

  Future<void> openCamera() async {
    try {
      final imagePicked =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (imagePicked != null) {
        imageFile.value = File(imagePicked.path);
      }
    } on PlatformException catch (e) {
      if (e.code == PlatformException(code: "camera_access_denied")) {
        print("error : $e");
      }
    }
  }

  @override
  void onInit() {
    usernameController = TextEditingController();
    usernameController.text = "John Doe";
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
