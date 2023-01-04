import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_playstation_detail_response.dart';
import 'package:victoria_game/app/core/repository/order_at_home_repository.dart';
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

  late GoogleMapController mapController;
  late TextEditingController descriptionController;
  late OrderAtHomePlaystationDetail playstationData;

  RxList<Marker> myMarker = <Marker>[].obs;

  late double markedLatitude;
  late double markedLongitude;
  RxString address = "".obs;
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
      markedLatitude = shipment["latitude"];
      markedLongitude = shipment["longitude"];
      address.value = shipment["address"];
      isUseMap = true;
    }
  }

  Future<void> fetchOrderData() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";
    var result = await _orderAtHomeRepository.fetchPlaystationData(
        authToken: authToken, playstationId: playstationId);


    if (result.data != null) {
      playstationData = result.data!;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(markedLatitude, markedLongitude),
          zoom: 15,
        ),
      ),
    );

    Marker initialLocationMarker = Marker(
      position: LatLng(markedLatitude, markedLongitude),
      markerId: const MarkerId("2"),
      infoWindow: const InfoWindow(title: "Pilih Lokasi"),
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: false,
    );

    myMarker.add(initialLocationMarker);
  }

  void onSubmitOrder() {
    Get.dialog(
      ConfirmationActionDialog(
        title: "Tolong Cek Pesanan Kamu Ya!",
        description:
            "Harap periksa ulang pesanan kamu, agar tidak terjadi kesalahan ya!",
        buttonFunction: () {
          Get.back();
          Get.toNamed(Routes.ORDER_DETAILS_AT_HOME_VERIFY, arguments: {
            "playstationType": playstationType,
            "date": {
              "start": startDate,
              "finish": finishDate,
            },
            "payment": payment,
            "totalAmount": totalAmount,
            "playtime": playtime,
            "playstationData": playstationData,
            "shipment": shipment,
            "notes": descriptionController.text,
          });
        },
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    initiatePage();
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
