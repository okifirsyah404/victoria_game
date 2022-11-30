import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';

import '../../../routes/app_pages.dart';

class MapsController extends GetxController {
  var arguments = Get.arguments;

  Map<String?, dynamic>? get shipmentData => arguments[4];

  loc.Location location = loc.Location();
  late GoogleMapController mapController;

  RxBool isMapLoading = true.obs;

  RxDouble markedLatitude = 0.0.obs;
  RxDouble markedLongitude = 0.0.obs;

  LatLng initialCameraPosition = const LatLng(-7.9282521, 113.8162798);

  RxList<Marker> myMarker = <Marker>[].obs;
  RxString locationPlacemark = "".obs;

  void getCurrentLocation() async {
    bool isServiceEnable;
    loc.PermissionStatus permissionGranted;
    isServiceEnable = await location.serviceEnabled();

    if (!isServiceEnable) {
      isServiceEnable = await location.requestService();
      if (!isServiceEnable) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    initialCameraPosition = LatLng(position.latitude, position.longitude);
    markedLatitude.value = position.latitude;
    markedLongitude.value = position.longitude;
    isMapLoading.value = false;

    locationPlacemark.value =
        "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(markedLatitude.value, markedLongitude.value),
          zoom: 15,
        ),
      ),
    );
    Marker initialLicationMarker = Marker(
      position: LatLng(markedLatitude.value, markedLongitude.value),
      markerId: const MarkerId("1"),
      infoWindow: const InfoWindow(title: "Pilih Lokasi"),
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: true,
    );
    myMarker.add(initialLicationMarker);
  }

  void handleMapOnTap(LatLng tapPoint) async {
    myMarker.add(
      Marker(markerId: MarkerId(tapPoint.toString()), position: tapPoint),
    );
    myMarker.removeAt(0);
    print(tapPoint);
    markedLatitude.value = tapPoint.latitude;
    markedLongitude.value = tapPoint.longitude;

    List<Placemark> placemark =
        await placemarkFromCoordinates(tapPoint.latitude, tapPoint.longitude);

    locationPlacemark.value =
        "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
  }

  double calculateDistance(LatLng coordinates) {
    double gameCenterLatitude = -7.154877;
    double gameCenterLongitude = 111.875865;

    double result = Geolocator.distanceBetween(coordinates.latitude,
        coordinates.longitude, gameCenterLatitude, gameCenterLongitude);
    return result;
  }

  void onSubmitMap() {
    var distance =
        calculateDistance(LatLng(markedLatitude.value, markedLongitude.value));
    print(distance);

    if (distance > 10000.0) {
      Get.dialog(
        SingleActionDialog(
          title: "Jarak Kamu Terlalu Jauh",
          description:
              "Jarak posisi kamu terlalu jauh dari Game Center, Seperti jarak dia sama kamu!",
        ),
      );
    } else {
      Get.toNamed(
        Routes.ORDER_DETAILS_AT_HOME_OVERVIEW,
        arguments: [
          arguments[0],
          arguments[1],
          arguments[2],
          arguments[3],
          {
            "methodTitle": shipmentData?["methodTitle"],
            "description": shipmentData?["description"],
            "address": locationPlacemark.value,
            "latitude": markedLatitude.value,
            "longitude": markedLongitude.value,
          },
        ],
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
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
