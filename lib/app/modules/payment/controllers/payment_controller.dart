import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class PaymentController extends GetxController {
  final _arguments = Get.arguments;

  Map<String, dynamic> get itemData => _arguments[0];
  Map<String, dynamic>? get paymentMethod => _arguments[1];

  late Rxn<int> selectedIndex;

  List<Map<String, dynamic>> get _paymentMethods => [
        {
          "method": "Saldo",
          "ballance": 1000000,
        },
        {
          "method": "Tunai",
        },
      ];

  List<Map<String, dynamic>> get paymentMethods => _paymentMethods;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void backWithOption() {
    Get.back(
      result: {
        "method": paymentMethods[selectedIndex.value ?? 1]["method"],
        "ballance": paymentMethods[selectedIndex.value ?? 1]["ballance"],
      },
    );
  }

  void initialPaymentMethod() {
    selectedIndex.value = -1;
    if (paymentMethod != null && paymentMethod?["method"] != "") {
      for (var i = 0; i < paymentMethods.length; i++) {
        if (paymentMethods[i]["method"] == paymentMethod?["method"]) {
          selectedIndex.value = i;
        }
      }
    }
  }

  @override
  void onInit() {
    selectedIndex = Rxn<int>();
    initialPaymentMethod();
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
}
