import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_available_playstation_response.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_playstation_detail_response.dart';
import 'package:victoria_game/app/core/repository/order_at_home_repository.dart';
import 'package:victoria_game/app/core/repository/order_on_site_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/confirmation_action_dialog/confirmation_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class OrderDetailsAtHomeOverviewController extends GetxController {
  final _arguments = Get.arguments;

  late SecureStorage _secureStorage;
  late OrderAtHomeRepository _orderAtHomeRepository;

  String get playstationType => _arguments["playstationType"];
  DateTime get startDate => _arguments["date"]["start"];
  DateTime get finishDate => _arguments["date"]["finish"];
  Map<String, dynamic> get payment => _arguments["payment"];
  int get totalAmount => _arguments["totalAmount"];
  int get playtime => _arguments["playtime"];
  String get playstationId => _arguments["playstationData"].playstationId;
  Map<String, dynamic> get shipment => _arguments["shipment"];

  final formKey = GlobalKey<FormState>();

  RxBool isPageLoading = true.obs;

  late GoogleMapController mapController;
  late TextEditingController descriptionController;
  late OrderAtHomePlaystationDetail playstationData;

  RxList<Marker> myMarker = <Marker>[].obs;

  RxDouble markedLatitude = 0.0.obs;
  RxDouble markedLongitude = 0.0.obs;
  bool isUseMap = false;

  RxString startDateText = "".obs;
  RxString lastDateText = "".obs;
  RxString? paymentMethod = "".obs;
  RxInt? paymentMethodBallance = 0.obs;
  RxString? shipmentMethod = "".obs;
  RxString? shipmentMethodDescription = "".obs;

  void initiatePage() {
    startDateText.value = DateFormat("dd MMMM yyyy", "id_ID").format(startDate);
    lastDateText.value = DateFormat("dd MMMM yyyy", "id_ID").format(finishDate);

    paymentMethod?.value = payment["paymentMethod"];
    paymentMethodBallance?.value = payment["ballance"];

    shipmentMethod?.value = shipment["method"];
    shipmentMethodDescription?.value = shipment["description"];

    if (shipment["latitude"] != null && shipment["longitude"] != null) {
      markedLatitude.value = shipment["latitude"];
      markedLongitude.value = shipment["longitude"];
      isUseMap = true;
    }

    isPageLoading.value = false;
  }

  Future<void> fetchOrderData() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _orderAtHomeRepository.fetchPlaystationData(
        authToken: authToken, playstationId: playstationId);

    if (result.data != null) {
      playstationData = result.data!;
      initiatePage();
    }
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

  void onSubmitOrder() {
    Get.dialog(
      ConfirmationActionDialog(
        title: "Tolong Cek Pesanan Kamu Ya!",
        description:
            "Harap periksa ulang pesanan kamu, agar tidak terjadi kesalahan ya!",
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _orderAtHomeRepository = OrderAtHomeRepository.instance;
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    if (isUseMap) {
      mapController.dispose();
    }
    super.onClose();
  }
}
