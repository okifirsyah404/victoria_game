import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';

import '../../../../routes/app_pages.dart';

class OrderDetailsOnSiteController extends GetxController {
  //TODO: Implement OrderDetailsOnSiteController, and cleaning the code

  final formKey = GlobalKey<FormState>();

  late TextEditingController calendarTextController;
  late TextEditingController timeTextController;
  late RxString dropDownInitialSelected;

  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  List<String> listItem = List.generate(6, (index) => "${index + 1} Jam");

  RxString paymentMethod = "".obs;
  RxInt paymentMethodBallance = (-1).obs;

  void onChangeDropDown(String? newValue) {
    dropDownInitialSelected.value = newValue ?? "";
    print(dropDownInitialSelected);
    // Get.back()
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
              primary: ColorsTheme.primaryColor, // header background color
              onPrimary: ColorsTheme.neutralColor[900] ??
                  ColorsTheme.neutralColor, // header text color
              onSurface: ColorsTheme.primaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorsTheme.primaryColor, // button text color
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
      print(selectedDate);
    }
  }

  Future<TimeOfDay?> openTimePicker(BuildContext context) async {
    final timePicked = await showTimePicker(
      confirmText: "OKE",
      cancelText: "BATAL",
      helpText: "Pilih Jam",
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
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
    if (timePicked != null) {
      timeTextController.text = "${timePicked.hour}:${timePicked.minute}";

      // TODO: Implement when user submit
      // selectedDate.value = DateTime(
      //     selectedDate.value.year,
      //     selectedDate.value.month,
      //     selectedDate.value.day,
      //     timePicked.hour,
      //     timePicked.minute);
      print(selectedDate);
    }
  }

  Future<void> initiatePaymentMethod() async {
    var result = await Get.toNamed(Routes.PAYMENT);

    paymentMethod.value = result["method"];
    paymentMethodBallance.value = result["ballance"] ?? -1;
  }

  @override
  void onInit() {
    calendarTextController = TextEditingController();
    timeTextController = TextEditingController();
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
