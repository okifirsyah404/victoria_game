import 'package:android_intent_plus/android_intent.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';

class DetailGameCenterController extends GetxController {
  //TODO: Implement DetailGameCenterController

  var gameCenterArguments = Get.arguments;

  double get markedLatitude => gameCenterArguments.latitude;
  double get markedLongitude => gameCenterArguments.longitude;
  String get placeName => gameCenterArguments.name;
  int get totalPlaystation => gameCenterArguments.totalPlaystaion;
  int get playstation3 => gameCenterArguments.playstation3;
  int get playstation4 => gameCenterArguments.playstation4;
  List<PlaystationsData> get playstationsData =>
      gameCenterArguments.playstationsData;

  RxList<Marker> myMarker = <Marker>[].obs;
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
      if (locationPermission == LocationPermission.denied)
        return Future.error("Location Permission ditolak");
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
    print(placemarks);
    Placemark place = placemarks[0];

    addressMessage.value =
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country} ";
  }

  void changeLocationMessage(Position position) {
    locationMessage.value =
        "Lat : ${position.latitude}, Long : ${position.longitude}";
  }

  void onMapCreated(GoogleMapController controller) {
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(markedLatitude, markedLongitude),
          zoom: 15,
        ),
      ),
    );
    Marker initialLicationMarker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(markedLatitude, markedLongitude),
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: true,
    );
    myMarker.add(initialLicationMarker);
  }

  void intentGoogleMaps() {
    var intentPlaceName = placeName.replaceAll(RegExp("\\s+"), '+');
    final intent = AndroidIntent(
        action: "android.intent.action.VIEW",
        data: Uri.encodeFull(
            "geo:$markedLatitude,$markedLongitude?q=$intentPlaceName"),
        package: "com.google.android.apps.maps");

    intent.launch();
  }

  final count = 0.obs;
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

  void increment() => count.value++;
}
