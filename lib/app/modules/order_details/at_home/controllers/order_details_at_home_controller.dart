import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/summary_at_home_playstation_list_response.dart';
import 'package:victoria_game/app/core/repository/order_at_home_repository.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class OrderDetailsAtHomeController extends GetxController {
  final _arguments = Get.arguments;

  String get playstationType => _arguments["playstationType"];

  late SecureStorage _secureStorage;
  late OrderAtHomeRepository _orderAtHomeRepository;
  final formKey = GlobalKey<FormState>();

  late SummaryAtHomePlaystationType itemData;

  late TextEditingController calendarTextController;
  late Rx<DateTimeRange?> selectedDateRange;

  RxString paymentMethod = "".obs;
  RxInt paymentMethodBallance = (-1).obs;

  late int baseRentPrice;
  RxInt totalAmount = 0.obs;
  late int playtime;

  Future<void> fetchItemData() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _orderAtHomeRepository.getAvailablePlaystationDataByType(
        authToken: authToken, playstationType: playstationType);

    if (result.data != null) {
      itemData = result.data!;

      baseRentPrice = itemData.price!;
      totalAmount.value = baseRentPrice;
    }

  }

  Future<DateTimeRange?> openDateRangePicker(
      {DateTime? firstDate, DateTimeRange? initalDateRange}) async {
    final DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: Get.context!,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime(2101),
      initialDateRange: initalDateRange ??
          DateTimeRange(
              start: DateTime.now(),
              end: DateTime.now().add(const Duration(days: 1))),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: ColorsTheme.primaryColor,
              onPrimary: ColorsTheme.neutralColor[900]!,
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
      locale: const Locale('id', 'ID'),
      confirmText: "Konfirmasi",
      saveText: "Konfirmasi",
    );
    return dateTimeRange;
  }

  void openDatePicker() async {
    DateTimeRange? timePicked = await openDateRangePicker(
      firstDate: DateTime.now(),
      initalDateRange: selectedDateRange.value,
    );

    if (timePicked != null) {
      selectedDateRange.value = timePicked;
      calendarTextController.text =
          "${DateFormat("dd MMMM yyyy", "id_ID").format(selectedDateRange.value!.start)} - ${DateFormat("dd MMMM yyyy", "id_ID").format(selectedDateRange.value!.end)}";

      playtime = compareDateInDays(
          selectedDateRange.value!.start, selectedDateRange.value!.end);
      totalAmount.value = baseRentPrice * playtime;
    }
  }

  int compareDateInDays(DateTime firstDate, DateTime lastDate) {
    var timeInterval = firstDate.difference(lastDate);
    return -(timeInterval.inHours / 24).round();
  }

  Future<void> initiatePaymentMethod() async {
    if (calendarTextController.text.isEmpty) {
      Get.dialog(const SingleActionDialog(
        title: "Silahkan Pilih Tanggal",
        description:
            "Tanggal mulai main atau tanggal selesai main tidak boleh kosong nih!",
      ));
    }

    else {
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

  void onSumbit() {
    if (selectedDateRange.value != null) {
      if (calendarTextController.text.isEmpty) {
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
          Routes.ORDER_DETAILS_AT_HOME_PLAYSTATION_LIST,
          arguments: {
            "playstationType": itemData.playstationType,
            "date": {
              "start": selectedDateRange.value!.start,
              "finish": selectedDateRange.value!.end,
            },
            "payment": {
              "paymentMethod": paymentMethod.value,
              "ballance": paymentMethodBallance.value,
            },
            "totalAmount": totalAmount.value,
            "playtime": playtime,
          },
        );
      }
    } else {
      Get.dialog(const SingleActionDialog(
        title: "Silahkan Pilih Tanggal",
        description:
            "Tanggal mulai main atau tanggal selesai main tidak boleh kosong nih!",
      ));
    }
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _orderAtHomeRepository = OrderAtHomeRepository.instance;
    calendarTextController = TextEditingController();
    selectedDateRange = Rx<DateTimeRange?>(null);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    calendarTextController.dispose();
    super.onClose();
  }
}
