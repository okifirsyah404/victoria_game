import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MapsController extends GetxController {
  var gameCenterArguments = Get.arguments;

  loc.Location location = loc.Location();
  late GoogleMapController mapController;

  // double get markedLatitude => gameCenterArguments.latitude;
  // double get markedLongitude => gameCenterArguments.longitude;

  RxBool isMapLoading = true.obs;

  RxDouble markedLatitude = 0.0.obs;
  RxDouble markedLongitude = 0.0.obs;

  LatLng initialCameraPosition = LatLng(-7.9282521, 113.8162798);

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
      infoWindow: InfoWindow(title: "Pilih Lokasi"),
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
