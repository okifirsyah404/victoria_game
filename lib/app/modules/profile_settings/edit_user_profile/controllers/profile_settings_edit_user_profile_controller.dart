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
  final _secureStorage = SecureStorage();

  var imagePicker = ImagePicker();
  Rx<File> imageFile = File("").obs;

  late UserRepository _userRepository;
  late TextEditingController usernameController;
  late String authAccessToken;

  List<int> imageByte = [];

  bool isFileChange = false;

  Future<void> openCamera() async {
    var cameraPermission = await requestCameraGaleryPermissions();

    if (cameraPermission) {
      try {
        final imagePicked =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (imagePicked != null) {
          File tempFile = await compressFile(File(imagePicked.path));
          imageFile.value = tempFile;
          isFileChange = true;

          Get.back();
        }
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  Future<void> openGallery() async {
    var galleryPermission = await requestCameraGaleryPermissions();

    if (galleryPermission) {
      try {
        final imagePicked =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (imagePicked != null) {
          File tempFile = await compressFile(File(imagePicked.path));
          imageFile.value = tempFile;
          isFileChange = true;

          Get.back();
        }
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  Future<bool> requestCameraGaleryPermissions() async {
    var cameraGaleryPermission =
        await _userRepository.handleCameraGaleryPermission();

    _userRepository.printLog.d(cameraGaleryPermission);

    if (!cameraGaleryPermission) {
      Get.dialog(
        SingleActionDialog(
          title: "Akses Kamera Dan Galeri Ditolak",
          description:
              "Kami membutuhkan akses kamera serta galeri untuk mengupdate profile kamu.",
          buttonFunction: () async {
            await _userRepository.requestOpenAppSettings();
            Get.back();
          },
        ),
      );

      return false;
    }

    return cameraGaleryPermission;
  }

  Future<void> fetchUserImage(String authToken) async {
    var result = await _userRepository.getMethodRaw("/api/user/image",
        headers: {_userRepository.authorization: authToken});

    imageByte = [...result.bodyBytes];
  }

  Future<UserDataResponse> fetchUserData() async {
    authAccessToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var userData = await _userRepository.fetchUserData(authAccessToken);
    usernameController.text = userData.data?.username ?? "";

    await fetchUserImage(authAccessToken);

    return userData;
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 50, percentage: 50);

    return compressedFile;
  }

  onSubmitEdit() async {
    authAccessToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    if (isFileChange) {
      await _userRepository.updateUserProfile(
          authToken: authAccessToken, file: imageFile.value);
    }

    await _userRepository
        .updateUsername(
            authToken: authAccessToken, newUsername: usernameController.text)
        .then((value) => Get.offNamedUntil(
              Routes.PROFILE_SETTINGS_USER_PROFILE,
              (route) => route.isFirst,
            ));
  }

  @override
  void onInit() {
    super.onInit();
    _userRepository = UserRepository.instance;
    requestCameraGaleryPermissions();
    usernameController = TextEditingController();
  }

  @override
  void onClose() {
    if (isFileChange) {
      imageFile.value.delete();
    }
    usernameController.dispose();
    super.onClose();
  }
}
