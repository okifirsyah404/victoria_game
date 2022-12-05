import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:victoria_game/app/core/network/response/user_data_response.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class ProfileSettingsEditUserProfileController extends GetxController {
  //TODO: Implement ProfileSettingsEditUserProfileController

  final storage = SecureStorage();

  var imagePicker = ImagePicker();
  Rx<File> imageFile = File("").obs;

  late UserRepository userRepository;
  late TextEditingController usernameController;
  late String authAccessToken;

  Future<void> openCamera() async {
    var cameraPermission = await requestCameraGaleryPermissions();

    print(cameraPermission);

    if (cameraPermission) {
      try {
        final imagePicked =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (imagePicked != null) {
          File tempFile = await compressFile(File(imagePicked.path));

          imageFile.value = tempFile;
        }
      } on PlatformException catch (e) {
        // print(e);
        Get.dialog(SingleActionDialog(
          title: "Akses Kamera Ditolak",
          description: "Lorem Ipsum Dolor Sit Amet",
        ));
      }
    }
  }

  Future<bool> requestCameraGaleryPermissions() async {
    var cameraGaleryPermission =
        await userRepository.handleCameraGaleryPermission();

    userRepository.printLog.d(cameraGaleryPermission);

    if (!cameraGaleryPermission) {
      Get.dialog(
        SingleActionDialog(
          title: "Akses Kamera Dan Galeri Ditolak",
          description:
              "Kami membutuhkan akses kamera serta galeri untuk mengupdate profile kamu.",
          buttonFunction: () async {
            await userRepository.requestOpenAppSettings();
          },
        ),
      );

      return false;
    }

    return cameraGaleryPermission;
  }

  Future<UserDataResponse> fetchUserData() async {
    authAccessToken = await storage.readDataFromStrorage("token") ?? "";

    var userData = await userRepository.fetchUserData(authAccessToken);
    usernameController.text = userData.data?.username ?? "";

    return userData;
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 50, percentage: 50);

    return compressedFile;
  }

  onSubmitEdit() async {
    authAccessToken = await storage.readDataFromStrorage("token") ?? "";

    await userRepository
        .updateUserProfile(authToken: authAccessToken, file: imageFile.value)
        .then((value) => Get.offNamedUntil(
              Routes.PROFILE_SETTINGS_USER_PROFILE,
              (route) => route.isFirst,
            ));

    // Get.offNamedUntil(
    //   Routes.PROFILE_SETTINGS_USER_PROFILE,
    //   (route) => route.isFirst,
    // );
  }

  @override
  void onInit() {
    userRepository = UserRepository.instance;
    requestCameraGaleryPermissions();
    usernameController = TextEditingController();
    fetchUserData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    imageFile.value.delete();
    super.onClose();
  }
}
