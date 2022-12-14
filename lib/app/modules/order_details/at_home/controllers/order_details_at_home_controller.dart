import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class OrderDetailsAtHomeController extends GetxController {
  final _arguments = Get.arguments;

  final formKey = GlobalKey<FormState>();

  RxBool isPageLoading = true.obs;

  late TextEditingController initCalendarTextController;
  late TextEditingController endCalendarTextController;
  late RxString dropDownInitialSelected;

  Rx<DateTime?> selectedInitDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);

  RxString paymentMethod = "".obs;
  RxInt paymentMethodBallance = (-1).obs;

  RxString shipmentMethod = "".obs;
  RxString shipmentMethodDescription = "".obs;

  Map<String, dynamic> get itemData => _arguments["psData"];

  late Rx<int> totalAmount = Rx(itemData["price"]);
  int? timeInterval;

  void onChangeDropDown(String? newValue) {
    dropDownInitialSelected.value = newValue ?? "";
  }

  Future<DateTime?> openDatePicker(BuildContext context,
      {DateTime? firstDate, DateTime? lastDate, DateTime? initialDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime(2101),
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

    return picked;
  }

  void initTimePicked(BuildContext context) async {
    DateTime? timePicked = await openDatePicker(
      context,
      lastDate: selectedEndDate.value?.subtract(const Duration(days: 1)),
      initialDate: selectedInitDate.value,
    );

    if (timePicked != null && timePicked != selectedInitDate) {
      selectedInitDate.value = timePicked;
      initCalendarTextController.text = DateFormat("dd MMMM yyyy", "id_ID")
          .format(selectedInitDate.value ?? DateTime.now());
    }
  }

  void endTimePicked(BuildContext context) async {
    DateTime? timePicked = await openDatePicker(
      context,
      firstDate: selectedInitDate.value?.add(const Duration(days: 1)) ??
          DateTime.now().add(const Duration(days: 1)),
      initialDate:
          selectedEndDate.value ?? DateTime.now().add(const Duration(days: 1)),
    );

    if (timePicked != null && timePicked != selectedEndDate) {
      selectedEndDate.value = timePicked;
      endCalendarTextController.text = DateFormat("dd MMMM yyyy", "id_ID")
          .format(selectedEndDate.value ?? DateTime.now());

      timeInterval = compareDateInDays(selectedEndDate.value ?? DateTime.now(),
          selectedInitDate.value ?? DateTime.now());

      var tempTotal = itemData["price"] * timeInterval;
      totalAmount.value = tempTotal;
    }
  }

  int compareDateInDays(DateTime firstDate, DateTime lastDate) {
    var timeInterval = firstDate.difference(lastDate);
    return (timeInterval.inHours / 24).round();
  }

  Future<void> initiatePaymentMethod() async {
    if (initCalendarTextController.text.isEmpty ||
        endCalendarTextController.text.isEmpty) {
      Get.dialog(const SingleActionDialog(
        title: "Silahkan Pilih Tanggal",
        description:
            "Tanggal mulai main atau tanggal selesai main tidak boleh kosong nih!",
      ));
    } else {
      var result = await Get.toNamed(Routes.PAYMENT, arguments: {
        "previousMethod": {
          "method": paymentMethod.value,
          "ballance": paymentMethodBallance.value,
        },
        "totalAmount": totalAmount.value,
      });

      paymentMethod.value = result?["method"] ?? "";
      paymentMethodBallance.value = result?["ballance"] ?? -1;
    }
  }

  void initiateShipmentMethod() {
    if (initCalendarTextController.text.isEmpty ||
        endCalendarTextController.text.isEmpty) {
      Get.dialog(const SingleActionDialog(
        title: "Silahkan Pilih Tanggal",
        description:
            "Tanggal mulai main atau tanggal selesai main tidak boleh kosong nih!",
      ));
    } else if (paymentMethodBallance.value < totalAmount.value &&
        paymentMethodBallance.value > -1) {
      Get.dialog(const SingleActionDialog(
        title: "Jumlah Saldo Kamu Kurang Nih",
        description:
            "Jumlah saldo kamu tidak mencukupi nih! Coba pakai metode pembayaran lain",
      ));
    } else if (paymentMethod.value.isEmpty) {
      Get.dialog(const SingleActionDialog(
        title: "Metode Pembayaran Belum Dipilih",
        description:
            "Kamu belum memilih metode pembayaran nih! Silahkan pilih ya!",
      ));
    } else {
      Get.toNamed(
        Routes.SHIPMENT,
        arguments: {
          "psData": itemData,
          "date": {
            "startDate": selectedInitDate.value,
            "lastDate": selectedEndDate.value,
          },
          "payment": {
            "paymentMethod": paymentMethod.value,
            "ballance": paymentMethodBallance.value,
          },
          "totalAmount": totalAmount.value,
        },
      );
    }
  }

  void initiatePage() {
    isPageLoading.value = false;
  }

  @override
  void onInit() {
    initCalendarTextController = TextEditingController();
    endCalendarTextController = TextEditingController();

    initiatePage();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    initCalendarTextController.dispose();
    endCalendarTextController.dispose();
    super.onClose();
  }
}
