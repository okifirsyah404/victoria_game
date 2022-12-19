import 'package:android_intent_plus/android_intent.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';
import 'package:victoria_game/app/core/repository/game_center_repository.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class DetailGameCenterController extends GetxController {
  final _arguments = Get.arguments;

  String get locationId => _arguments["location"];
  late SecureStorage secureStorage;
  late GameCenterRepository gameCenterRepository;
  late UserRepository userRepository;

  late String authAccessToken;
  late GoogleMapController mapController;

  late List<int> imageByte;
  late String gameCenterName;
  late int playstation3;
  late int playstation4;

  late List<PlaystationList> playstationList;

  late double markedLatitude;
  late double markedLongitude;

  RxList<Marker> myMarker = <Marker>[].obs;
  RxString locationMessage = "Belum mendapat Lat dan Long".obs;
  RxString addressMessage = "Mencari Lokasi".obs;

  Future<bool> requestLocationPermission() async {
    var locationPermission = await userRepository.handleLocationPermission();

    userRepository.printLog.d(locationPermission);

    if (!locationPermission) {
      Get.dialog(
        SingleActionDialog(
          title: "Akses Lokasi Ditolak",
          description:
              "Kami membutuhkan akses lokasi untuk mengetahui jarak kamu dengan game center.",
          buttonFunction: () async {
            await userRepository.requestOpenAppSettings();
            Get.back();
          },
        ),
      );

      return false;
    }

    return locationPermission;
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service belum aktif");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission ditolak");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permission ditolak, gagal request permissions");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "id_ID");
    Placemark place = placemarks[0];

    addressMessage.value =
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country} ";
  }

  void changeLocationMessage(Position position) {
    locationMessage.value =
        "Lat : ${position.latitude}, Long : ${position.longitude}";
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(markedLatitude, markedLongitude),
          zoom: 15,
        ),
      ),
    );
    Marker initialLicationMarker = Marker(
      markerId: const MarkerId("1"),
      position: LatLng(markedLatitude, markedLongitude),
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: true,
    );
    myMarker.add(initialLicationMarker);
  }

  void intentGoogleMaps() {
    var intentPlaceName = gameCenterName.replaceAll(RegExp("\\s+"), '+');
    final intent = AndroidIntent(
        action: "android.intent.action.VIEW",
        data: Uri.encodeFull(
            "geo:$markedLatitude,$markedLongitude?q=$intentPlaceName"),
        package: "com.google.android.apps.maps");

    intent.launch();
  }

  Future<void> fetchGameCenterImage(String authToken, String locationId) async {
    var headers = {gameCenterRepository.authorization: authToken};

    var body = {"id": locationId};

    var result = await gameCenterRepository
        .postMethodRaw("/api/game-center/image", headers: headers, body: body);

    imageByte = [...result.bodyBytes];
  }

  Future<void> fetchGameCenterDetail() async {
    authAccessToken = await secureStorage.readDataFromStrorage("token") ?? "";

    var result = await gameCenterRepository.fetchGameCenterDetail(
        authToken: authAccessToken, locationId: locationId);

    await fetchGameCenterImage(authAccessToken, locationId);

    markedLatitude = double.parse(result.data?.latitude ?? "-7.154825");
    markedLongitude = double.parse(result.data?.longitude ?? "111.875869");

    gameCenterName = "${result.data?.name}".toTitleCase();
    playstation3 = result.data?.playstation3 ?? 0;
    playstation4 = result.data?.playstation4 ?? 0;

    playstationList = [...?result.data?.playstationList];
  }

  void onSelectedPlaystationItem(int index) {
    if (playstationList[index].status != "tidak aktif") {
      Get.dialog(SingleActionDialog(
        title: "Playstation Masih Dimainkan",
        description:
            "Playstation ini masih dimainkan, anda bisa pilih tanggal lain",
        buttonFunction: () {
          Get.back();
          Get.toNamed(Routes.ORDER_DETAILS_ON_SITE, arguments: {
            "location": locationId,
            "playstationId": playstationList[index].id,
          });
        },
      ));
    } else {
      Get.toNamed(Routes.ORDER_DETAILS_ON_SITE, arguments: {
        "location": locationId,
        "playstationId": playstationList[index].id,
      });
    }
  }

  @override
  void onInit() {
    secureStorage = SecureStorage.instance;
    gameCenterRepository = GameCenterRepository.instance;
    userRepository = UserRepository.instance;
    requestLocationPermission();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
}
