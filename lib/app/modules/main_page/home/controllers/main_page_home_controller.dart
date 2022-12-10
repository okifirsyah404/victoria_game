import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_list_res.dart';

import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';
import 'package:victoria_game/app/core/repository/game_center_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';

import 'package:victoria_game/utils/secure_storage.dart';

class MainPageHomeController extends GetxController {
  final storage = SecureStorage();

  late UserRepository userRepository;
  late GameCenterRepository gameCenterRepository;

  late String authAccessToken;

  List<int> imageByte = [];

  String username = "John Doe";
  int ballance = 1000;
  int playTime = 0;

  RxString locationMessage = "Belum mendapat Lat dan Long".obs;
  RxString addressMessage = "Mencari Lokasi".obs;

  late Position myPosition;

  List<GameCenters> gameCenterList = [];

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

  // Future<String> fetchUserImage() async {
  //   return authToken;
  // }

  Future<Uint8List> fetchUserImage() async {
    String authAccessToken = await storage.readDataFromStrorage("token") ?? "";
    var result = await userRepository.getMethodRaw("/api/user/image",
        headers: {userRepository.authorization: authAccessToken});

    imageByte = [...result.bodyBytes];

    return result.bodyBytes;
  }

  Future<void> fetchUserData() async {
    String authToken = await storage.readDataFromStrorage("token") ?? "";

    var userData = await userRepository.fetchUserData(authToken);

    username = userData.data?.username ?? "";
    ballance = userData.data?.ballance ?? 1;
    playTime = userData.data?.playTime ?? 1;
  }

  Future<void> fetchGameCenters() async {
    String authToken = await storage.readDataFromStrorage("token") ?? "";

    var gameCenterData =
        await gameCenterRepository.fetchGameCentersList(authToken: authToken);

    print(gameCenterData.data?[0].name);
    gameCenterList = gameCenterData.data ?? [];
  }

  Future<void> initData() async {
    imageByte = await fetchUserImage();
    await fetchUserData();
    await fetchGameCenters();
  }

  @override
  void onInit() {
    userRepository = UserRepository.instance;
    gameCenterRepository = GameCenterRepository.instance;
    initData();
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
