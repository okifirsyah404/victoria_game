import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_list_res.dart';
import 'package:location/location.dart' as loc;

import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';
import 'package:victoria_game/app/core/repository/game_center_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/double_extensions.dart';
import 'package:victoria_game/utils/firebase_notification.dart';

import 'package:victoria_game/utils/secure_storage.dart';

class MainPageHomeController extends GetxController {
  final storage = SecureStorage();

  late UserRepository _userRepository;
  late GameCenterRepository _gameCenterRepository;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late String authAccessToken;

  List<int> imageByte = [];

  String username = "John Doe";
  int ballance = 1000;
  int playTime = 0;

  late Position myPosition;
  loc.Location location = loc.Location();

  List<GameCenters> gameCenterList = [];
  RxList<String> gameCenterLocationList = <String>[].obs;

  Future<void> requestAllRequiredPermission() async {
    var requiredPermission =
        await _userRepository.handleAllRequiredPermission();

    _userRepository.printLog.d(requiredPermission);

    if (!requiredPermission) {
      Get.dialog(
        SingleActionDialog(
          title: "Akses Permission Ditolak",
          description:
              "Kami membutuhkan semua permission untuk menjalankan aplikasi ini secara optimal.",
          buttonFunction: () async {
            await _userRepository.requestOpenAppSettings();
            Get.back();
          },
        ),
      );
    }

    myPosition = await Geolocator.getCurrentPosition();
  }

  double calculateDistance(LatLng gameCenterCoordiantes) {
    double gameCenterLatitude = gameCenterCoordiantes.latitude;
    double gameCenterLongitude = gameCenterCoordiantes.longitude;

    return Geolocator.distanceBetween(myPosition.latitude, myPosition.longitude,
        gameCenterLatitude, gameCenterLongitude);
  }

  Future<Uint8List> fetchUserImage() async {
    authAccessToken = await storage.readDataFromStrorage("token") ?? "";
    var result = await _userRepository.getMethodRaw("/api/user/image",
        headers: {_userRepository.authorization: authAccessToken});

    imageByte = [...result.bodyBytes];

    return result.bodyBytes;
  }

  Future<void> fetchUserData() async {
    var userData = await _userRepository.fetchUserData(authAccessToken);

    username = userData.data?.username ?? "";
    ballance = userData.data?.ballance ?? 1;
    playTime = userData.data?.playTime ?? 1;
  }

  Future<void> fetchGameCenters() async {
    String authToken = await storage.readDataFromStrorage("token") ?? "";

    var gameCenterData =
        await _gameCenterRepository.fetchGameCentersList(authToken: authToken);

    gameCenterList = gameCenterData.data ?? [];

    gameCenterList.forEach((element) {
      gameCenterLocationList.add(
        calculateDistance(
          LatLng(
            double.parse(element.latitude!),
            double.parse(element.longitude!),
          ),
        ).toKilometers(),
      );
    });
  }

  Future<void> initData() async {
    await requestAllRequiredPermission();
    imageByte = await fetchUserImage();
    await fetchUserData();
    await fetchGameCenters();
  }

  Future<void> onReadyData() async {
    imageByte = await fetchUserImage();
    await fetchUserData();
    await fetchGameCenters();
  }

  void onSelectedGameCenter(int index) {
    Get.toNamed(Routes.DETAIL_GAME_CENTER,
        arguments: {"location": gameCenterList[index].id});
  }

  Future<void> initFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((event) {
      showNotification(event, flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showNotification(event, flutterLocalNotificationsPlugin);
    });
    FirebaseMessaging.onBackgroundMessage((message) =>
        showNotification(message, flutterLocalNotificationsPlugin));
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print(message.messageType);
      }
    });
  }

  @override
  void onInit() {
    _userRepository = UserRepository.instance;
    _gameCenterRepository = GameCenterRepository.instance;
    initFirebaseMessaging();

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
