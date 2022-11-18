import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';

import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

class MainPageHomeController extends GetxController {
  //TODO: Implement MainPageHomeController

  // FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  // void signOut() {
  //   firebaseAuthServices.signOutUserPasswordBased();
  //   Get.offAllNamed(Routes.AUTH_SIGN_IN);
  // }

  RxString locationMessage = "Belum mendapat Lat dan Long".obs;
  RxString addressMessage = "Mencari Lokasi".obs;

  Position _myPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0.0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  var listItem = List.generate(
    7,
    (index) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorsTheme.neutralColor[600],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Tempat $index",
                style: TypographyTheme.titleSmall.copyWith(
                  color: ColorsTheme.primaryColor,
                ),
              ),
              Text("Alamat Tempat"),
            ],
          ),
        ),
      ),
    ),
  );

  Future<void> determinePosition() async {
    LocationPermission locationPermission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error("Location services belum aktif");

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission Ditolak");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permission Ditolak, Gagal Request Permissons");
    }

    _myPosition = await Geolocator.getCurrentPosition();
  }

  @override
  void onInit() {
    determinePosition();
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
