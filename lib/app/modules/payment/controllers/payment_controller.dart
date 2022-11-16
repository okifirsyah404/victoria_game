import 'package:get/get.dart';

class PaymentController extends GetxController {
  //TODO: Implement PaymentController

  final selectedIndex = 0.obs;

  List<Map<String, dynamic>> paymentMethods = [
    {
      "methodTitle": "Saldo",
      "ballance": 1000000,
    },
    {"methodTitle": "Tunai"},
  ];

  List<Map<String, dynamic>> get getPaymentMethods => paymentMethods;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
