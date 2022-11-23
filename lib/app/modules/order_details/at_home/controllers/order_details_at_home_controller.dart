import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class OrderDetailsAtHomeController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late TextEditingController initCalendarTextController;
  late TextEditingController endCalendarTextController;
  late RxString dropDownInitialSelected;

  Rx<DateTime?> selectedInitDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);

  RxString paymentMethod = "".obs;
  RxInt paymentMethodBallance = (-1).obs;
  RxString shipmentMethod = "".obs;

  void onChangeDropDown(String? newValue) {
    dropDownInitialSelected.value = newValue ?? "";
    print(dropDownInitialSelected);
    // Get.back()
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
      lastDate: selectedEndDate.value?.subtract(Duration(days: 1)),
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
      firstDate: selectedInitDate.value?.add(Duration(days: 1)) ??
          DateTime.now().add(Duration(days: 1)),
      initialDate:
          selectedEndDate.value ?? DateTime.now().add(Duration(days: 1)),
    );

    if (timePicked != null && timePicked != selectedEndDate) {
      selectedEndDate.value = timePicked;
      endCalendarTextController.text = DateFormat("dd MMMM yyyy", "id_ID")
          .format(selectedEndDate.value ?? DateTime.now());
      print(selectedEndDate.value
          ?.difference(selectedInitDate.value ?? DateTime.now()));
      print(compareDateInDays(selectedInitDate.value ?? DateTime.now(),
          selectedEndDate.value ?? DateTime.now()));
    }
  }

  Duration compareDateInDays(DateTime firstDate, DateTime lastDate) {
    var timeInterval = firstDate.difference(lastDate);
    return Duration(days: timeInterval.inDays);
  }

  Future<void> initiatePaymentMethod() async {
    var result =
        await Get.toNamed(Routes.PAYMENT, arguments: [paymentMethod.value]);

    paymentMethod.value = result?["method"] ?? "";
    paymentMethodBallance.value = result?["ballance"] ?? -1;
  }

  // TODO: Add Shipment option
  Future<void> initiateShipmentMethod() async {}

  @override
  void onInit() {
    initCalendarTextController = TextEditingController();
    endCalendarTextController = TextEditingController();
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
