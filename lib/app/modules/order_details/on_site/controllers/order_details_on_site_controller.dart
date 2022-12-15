import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/core/repository/order_on_site_repository.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/utils/secure_storage.dart';

import '../../../../routes/app_pages.dart';

class OrderDetailsOnSiteController extends GetxController {
  //TODO: Implement OrderDetailsOnSiteController, and cleaning the code

  final _arguments = Get.arguments;

  late SecureStorage secureStorage;
  late OrderOnSiteRepository orderOnSiteRepository;

  String get locationId => _arguments["location"];
  String get playstationId => _arguments["playstationId"];

  final formKey = GlobalKey<FormState>();

  late TextEditingController calendarTextController;
  late TextEditingController timeTextController;
  late RxString dropDownInitialSelected;

  late String gameCenterName;
  late String gameCenterAddress;
  late String playstationType;
  late String playstationNumber;
  late int baseRentPrice;
  late int totalAmount;

  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  late List<String> listItem = List.generate(6, (index) => "${index + 1} Jam");
  int selectedDropdownIndex = 1;

  RxString paymentMethod = "".obs;
  RxInt paymentMethodBallance = (-1).obs;

  void onChangeDropDown(String? newValue) {
    dropDownInitialSelected.value = newValue ?? "";
    selectedDropdownIndex = listItem.indexOf(newValue ?? "1 Jam") + 1;

    totalAmount = baseRentPrice * selectedDropdownIndex;
  }

  Future<void> openDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: const Locale("id"),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorsTheme.primaryColor,
              onPrimary:
                  ColorsTheme.neutralColor[900] ?? ColorsTheme.neutralColor,
              onSurface: ColorsTheme.primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorsTheme.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate.value = picked;
      calendarTextController.text =
          DateFormat("dd MMMM yyyy", "id_ID").format(selectedDate.value);
    }
  }

  Future<TimeOfDay?> openTimePicker(BuildContext context) async {
    final timePicked = await showTimePicker(
      confirmText: "OKE",
      cancelText: "BATAL",
      helpText: "Pilih Jam",
      hourLabelText: "",
      minuteLabelText: "",
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: ColorsTheme.primaryColor,
              onPrimary: ColorsTheme.primaryColor,
              onSurface: ColorsTheme.primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorsTheme.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (timePicked != null) {
      timeTextController.text = "${timePicked.hour}:${timePicked.minute}";

      selectedDate.value = DateTime(
          selectedDate.value.year,
          selectedDate.value.month,
          selectedDate.value.day,
          timePicked.hour,
          timePicked.minute);
      print(selectedDate);
    }
  }

  // FIXME: Fix receiver null
  Future<void> initiatePaymentMethod() async {
    var result = await Get.toNamed(Routes.PAYMENT, arguments: {
      "previousMethod": {
        "method": paymentMethod.value,
        "ballance": paymentMethodBallance.value,
      },
      "totalAmount": totalAmount,
    });

    paymentMethod.value = result?["method"] ?? "";
    paymentMethodBallance.value = result?["ballance"] ?? -1;
  }

  Future<void> fetchInitialOrderData() async {
    var authToken = await secureStorage.readDataFromStrorage("token") ?? "";
    var result = await orderOnSiteRepository.fetchSummaryOrder(
      authToken: authToken,
      gameCenterId: locationId,
      playstationId: playstationId,
    );

    gameCenterName = result.data?.locationName ?? "";
    gameCenterAddress = result.data?.locationAddress ?? "";
    playstationType = result.data?.playstationType ?? "";
    playstationNumber = result.data?.playstationId ?? "";
    baseRentPrice = result.data?.playstaionPrice ?? 0;
    totalAmount = baseRentPrice;
  }

  void onSubmitOrder() {
    if (calendarTextController.text.isEmpty) {
      Get.dialog(
        const SingleActionDialog(
          title: "Tanggal Main Belum Diisi",
          description:
              "Kamu belum memilih tanggal main. Silahkan pilih tanggal main kamu ya!",
        ),
      );
    } else if (timeTextController.text.isEmpty) {
      Get.dialog(
        const SingleActionDialog(
          title: "Waktu Main Belum Diisi",
          description:
              "Kamu belum memilih waktu main. Silahkan pilih waktu main kamu ya!",
        ),
      );
    } else if (selectedDate.value.isBefore(DateTime.now())) {
      Get.dialog(
        const SingleActionDialog(
          title: "Waktu Main Tidak Valid",
          description:
              "Kamu memilih waktu main yang tidak valid. Coba pilih waktu lain ya!",
        ),
      );
    } else if (paymentMethod.value.isEmpty) {
      Get.dialog(
        const SingleActionDialog(
          title: "Metode Pembayaran Tidak Valid",
          description:
              "Kamu belum memilih metode pembayaran. Silahkan pilih metode pembayaran ya!",
        ),
      );
    } else if (totalAmount > paymentMethodBallance.value &&
        paymentMethod.value == "Saldo") {
      Get.dialog(
        const SingleActionDialog(
          title: "Saldo Kamu Tidak Mencukupi",
          description:
              "Saldo kamu tidak mencukupi untuk main nih! Silahkan top up atau pilih metode pembayaran lain.",
        ),
      );
    } else {
      Get.toNamed(Routes.ORDER_DETAILS_ON_SITE_VERIFY, arguments: {
        "playtime": selectedDropdownIndex,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod.value,
        "gameCenterId": locationId,
        "playstationId": playstationId,
        "startPlay": "${selectedDate.value}",
        "endPlay": "${selectedDate.value.add(
          Duration(hours: selectedDropdownIndex),
        )}"
      });
    }
  }

  @override
  void onInit() {
    calendarTextController = TextEditingController();
    timeTextController = TextEditingController();
    orderOnSiteRepository = OrderOnSiteRepository.instance;
    secureStorage = SecureStorage.instance;
    dropDownInitialSelected = listItem[0].obs;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // calendarTextController.dispose();
  }
}
