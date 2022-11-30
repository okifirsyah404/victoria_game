import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class OrderDetailsAtHomeOverviewController extends GetxController {
  //TODO: Implement OrderDetailsAtHomeOverviewController

  var arguments = Get.arguments;

  Map<String, dynamic> get itemData => arguments[0];
  Map<String, DateTime?> get dateData => arguments[1];
  Map<String, dynamic> get paymentData => arguments[2];
  Map<String, int?> get totalAmountData => arguments[3];
  Map<String?, dynamic>? get shipmentData => arguments[4];

  final formKey = GlobalKey<FormState>();

  RxBool isPageLoading = true.obs;

  late GoogleMapController mapController;

  RxList<Marker> myMarker = <Marker>[].obs;

  RxDouble markedLatitude = 0.0.obs;
  RxDouble markedLongitude = 0.0.obs;

  RxString startDate = "".obs;
  RxString lastDate = "".obs;
  RxString? paymentMethod = "".obs;
  RxInt? paymentMethodBallance = 0.obs;
  late int? totalAmount;
  RxString? shipmentMethod = "".obs;
  RxString? shipmentMethodDescription = "".obs;

  void initiatePage() {
    startDate.value = DateFormat("dd MMMM yyyy", "id_ID")
        .format(dateData["startDate"] ?? DateTime.now());
    lastDate.value = DateFormat("dd MMMM yyyy", "id_ID")
        .format(dateData["lastDate"] ?? DateTime.now());

    paymentMethod?.value = paymentData["paymentMethod"] ?? "";
    paymentMethodBallance?.value = paymentData["ballance"] ?? -1;

    totalAmount = totalAmountData["totalAmount"];

    shipmentMethod?.value = shipmentData?["methodTitle"];
    shipmentMethodDescription?.value = shipmentData?["description"];

    markedLatitude.value = shipmentData?["latitude"] ?? 0;
    markedLongitude.value = shipmentData?["longitude"] ?? 0;

    isPageLoading.value = false;
    print(arguments);
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

  void onTimeAndPaymentChange() {
    Get.offNamedUntil(
      Routes.ORDER_DETAILS_AT_HOME,
      (route) => route.isFirst,
      arguments: [
        arguments[0],
      ],
    );
  }

  void onShipmentMethodChange() {
    Get.offNamedUntil(
      Routes.SHIPMENT,
      (route) => route.isFirst,
      arguments: [
        arguments[0],
        arguments[1],
        arguments[2],
        arguments[3],
      ],
    );
  }

  @override
  void onInit() {
    initiatePage();
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
