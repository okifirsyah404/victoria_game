import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';
import 'package:victoria_game/app/core/repository/game_center_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';

import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

class MainPageHomeController extends GetxController {
  // FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  // void signOut() {
  //   firebaseAuthServices.signOutUserPasswordBased();
  //   Get.offAllNamed(Routes.AUTH_SIGN_IN);
  // }

  RxBool isPageLoading = true.obs;

  late String authAccessToken;

  String username = "John Doe";
  int ballance = 1000;

  late GameCenterRepository gameCenterRepository;

  RxString locationMessage = "Belum mendapat Lat dan Long".obs;
  RxString addressMessage = "Mencari Lokasi".obs;

  late Position myPosition;

  var listItem = [
    GameCenters(
      id: "0a235236-67f4-4e9d-8110-cd4ca522531c",
      name: "Tolonto Game Bojonegoro",
      address:
          "Jl. Ade Irma Suryani No.43 A, Klangon, Kec. Bojonegoro, Kabupaten Bojonegoro",
      latitude: -7.154877,
      longitude: 111.875865,
      playstation3: 3,
      playstation4: 5,
      totalPlaystaion: 10,
      playstationsData: [
        PlaystationsData(
            psId: "c4ac4601-f3db-43c0-bf65-fe940d2f545d",
            psName: PsName.PLAYSTATION_3,
            psNumber: 1,
            psStatus: PsStatus.AVAILABLE,
            psPrice: 10000),
        PlaystationsData(
            psId: "f76a426f-1cad-4fa7-9649-ebc3114095e7",
            psName: PsName.PLAYSTATION_3,
            psNumber: 2,
            psStatus: PsStatus.UNAVAILABLE,
            psPrice: 10000),
        PlaystationsData(
            psId: "834e9744-202f-4d0b-9f33-608607a7db91",
            psName: PsName.PLAYSTATION_3,
            psNumber: 3,
            psStatus: PsStatus.MAINTENANCE,
            psPrice: 10000),
        PlaystationsData(
            psId: "05b98eb5-ab96-4c07-93f3-c1b0cdb53c27",
            psName: PsName.PLAYSTATION_4,
            psNumber: 4,
            psStatus: PsStatus.AVAILABLE,
            psPrice: 15000),
        PlaystationsData(
            psId: "9f46cd45-735b-472d-89e9-b8f1cc21b8d5",
            psName: PsName.PLAYSTATION_4,
            psNumber: 5,
            psStatus: PsStatus.UNAVAILABLE,
            psPrice: 15000),
        PlaystationsData(
            psId: "0a235236-67f4-4e9d-8110-cd4ca522531c",
            psName: PsName.PLAYSTATION_4,
            psNumber: 6,
            psStatus: PsStatus.MAINTENANCE,
            psPrice: 15000),
      ],
    ),
    GameCenters(
      id: "11a620cd-3ef1-4c36-81f8-6e7ca6ee478e",
      name: "Texas Game Bojonegoro",
      address: "Jambean, Sukorejo, Kec. Bojonegoro, Kabupaten Bojonegoro",
      latitude: -7.1636721,
      longitude: 111.8925933,
      playstation3: 10,
      playstation4: 15,
      totalPlaystaion: 10,
      playstationsData: [
        PlaystationsData(
            psId: "834e9744-202f-4d0b-9f33-608607a7db91",
            psName: PsName.PLAYSTATION_3,
            psNumber: 1,
            psStatus: psStatusValues.map["maintenance"],
            psPrice: 10000),
        PlaystationsData(
            psId: "c4ac4601-f3db-43c0-bf65-fe940d2f545d",
            psName: PsName.PLAYSTATION_3,
            psNumber: 2,
            psStatus: psStatusValues.map["available"],
            psPrice: 10000),
        PlaystationsData(
            psId: "f76a426f-1cad-4fa7-9649-ebc3114095e7",
            psName: PsName.PLAYSTATION_3,
            psNumber: 3,
            psStatus: psStatusValues.map["unavailable"],
            psPrice: 10000),
        PlaystationsData(
            psId: "9f46cd45-735b-472d-89e9-b8f1cc21b8d5",
            psName: PsName.PLAYSTATION_4,
            psNumber: 4,
            psStatus: psStatusValues.map["unavailable"],
            psPrice: 15000),
        PlaystationsData(
            psId: "05b98eb5-ab96-4c07-93f3-c1b0cdb53c27",
            psName: PsName.PLAYSTATION_4,
            psNumber: 5,
            psStatus: psStatusValues.map["available"],
            psPrice: 15000),
        PlaystationsData(
            psId: "0a235236-67f4-4e9d-8110-cd4ca522531c",
            psName: PsName.PLAYSTATION_4,
            psNumber: 6,
            psStatus: psStatusValues.map["maintenance"],
            psPrice: 15000),
      ],
    ),
  ];

  // FIXME: Use Permisson Service
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

    myPosition = await Geolocator.getCurrentPosition();
  }

  Future<String> fetchUserImage() async {
    var storage = const FlutterSecureStorage();
    String readData = await storage.read(key: "token") ?? "";
    return readData;
  }

  // @override
  // void onInit() {
  //   determinePosition();
  //   // fetchGameCentersData();
  //   super.onInit();
  // }

  void initUserData() async {
    authAccessToken = await fetchUserImage();
    isPageLoading.value = false;
  }

  @override
  void onInit() {
    initUserData();
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
